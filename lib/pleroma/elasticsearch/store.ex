defmodule Pleroma.Elasticsearch do
  alias Pleroma.Activity
  alias Pleroma.User
  alias Pleroma.Object
  alias Pleroma.Elasticsearch.DocumentMappings
  alias Pleroma.Config
  require Logger

  defp url do
    Config.get([:elasticsearch, :url])
  end

  defp enabled? do
    Config.get([:search, :provider]) == Pleroma.Search.Elasticsearch
  end

  def delete_by_id(:activity, id) do
    if enabled?() do
      Elastix.Document.delete(url(), "activities", "activity", id)
    end
  end

  def put_by_id(:activity, id) do
    id
    |> Activity.get_by_id_with_object()
    |> maybe_put_into_elasticsearch()
  end

  def maybe_put_into_elasticsearch({:ok, item}) do
    maybe_put_into_elasticsearch(item)
  end

  def maybe_put_into_elasticsearch(
        %{data: %{"type" => "Create"}, object: %{data: %{"type" => "Note"}}} = activity
      ) do
    if enabled?() do
      actor = Pleroma.Activity.user_actor(activity)

      activity
      |> Map.put(:user_actor, actor)
      |> put()
    end
  end

  def maybe_put_into_elasticsearch(%User{actor_type: "Person"} = user) do
    if enabled?() do
      put(user)
    end
  end

  def maybe_put_into_elasticsearch(_) do
    {:ok, :skipped}
  end

  def maybe_bulk_post(data, type) do
    if enabled?() do
      bulk_post(data, type)
    end
  end

  def put(%Activity{} = activity) do
    with {:ok, _} <-
           Elastix.Document.index(
             url(),
             "activities",
             "activity",
             DocumentMappings.Activity.id(activity),
             DocumentMappings.Activity.encode(activity)
           ) do
      activity
      |> Map.get(:object)
      |> Object.hashtags()
      |> Enum.map(fn x ->
        %{id: x, name: x, timestamp: DateTime.to_iso8601(DateTime.utc_now())}
      end)
      |> bulk_post(:hashtags)
    else
      {:error, %{reason: err}} ->
        Logger.error("Could not put activity: #{err}")
        :skipped
    end
  end

  def put(%User{} = user) do
    with {:ok, _} <-
           Elastix.Document.index(
             url(),
             "users",
             "user",
             DocumentMappings.User.id(user),
             DocumentMappings.User.encode(user)
           ) do
      :ok
    else
      {:error, %{reason: err}} ->
        Logger.error("Could not put user: #{err}")
        :skipped
    end
  end

  def bulk_post(data, :activities) do
    d =
      data
      |> Enum.filter(fn x ->
        t =
          x.object
          |> Map.get(:data, %{})
          |> Map.get("type", "")

        t == "Note"
      end)
      |> Enum.map(fn d ->
        [
          %{index: %{_id: DocumentMappings.Activity.id(d)}},
          DocumentMappings.Activity.encode(d)
        ]
      end)
      |> List.flatten()

    with {:ok, %{body: %{"errors" => false}}} <-
           Elastix.Bulk.post(
             url(),
             d,
             index: "activities",
             type: "activity"
           ) do
      :ok
    else
      {:error, %{reason: err}} ->
        Logger.error("Could not bulk put activity: #{err}")
        :skipped
      {:ok, %{body: body}} ->
        IO.inspect(body)
        :skipped
    end
  end

  def bulk_post(data, :users) do
    d =
      data
      |> Enum.filter(fn x -> x.actor_type == "Person" end)
      |> Enum.map(fn d ->
        [
          %{index: %{_id: DocumentMappings.User.id(d)}},
          DocumentMappings.User.encode(d)
        ]
      end)
      |> List.flatten()

    with {:ok, %{body: %{"errors" => false}}} <-
           Elastix.Bulk.post(
             url(),
             d,
             index: "users",
             type: "user"
           ) do
      :ok
    else
      {:error, %{reason: err}} ->
        Logger.error("Could not bulk put users: #{err}")
        :skipped
      {:ok, %{body: body}} ->
        IO.inspect(body)
        :skipped
    end
  end

  def bulk_post(data, :hashtags) when is_list(data) do
    d =
      data
      |> Enum.map(fn d ->
        [
          %{index: %{_id: DocumentMappings.Hashtag.id(d)}},
          DocumentMappings.Hashtag.encode(d)
        ]
      end)
      |> List.flatten()

    with {:ok, %{body: %{"errors" => false}}} <-
           Elastix.Bulk.post(
             url(),
             d,
             index: "hashtags",
             type: "hashtag"
           ) do
      :ok
    else
      {:error, %{reason: err}} ->
        Logger.error("Could not bulk put hashtags: #{err}")
        :skipped
      {:ok, %{body: body}} ->
        IO.inspect(body)
        :skipped
    end
  end

  def bulk_post(_, :hashtags), do: {:ok, nil}

  def search(_, _, _, :skip), do: []

  def search(:raw, index, type, q) do
    with {:ok, raw_results} <- Elastix.Search.search(url(), index, [type], q) do
      results =
        raw_results
        |> Map.get(:body, %{})
        |> Map.get("hits", %{})
        |> Map.get("hits", [])

      {:ok, results}
    else
      {:error, e} ->
        Logger.error(e)
        {:error, e}
    end
  end

  def search(:activities, q) do
    with {:ok, results} <- search(:raw, "activities", "activity", q) do
      results
      |> Enum.map(fn result -> result["_id"] end)
      |> Pleroma.Activity.all_by_ids_with_object()
      |> Enum.sort(&(&1.inserted_at >= &2.inserted_at))
    else
      e ->
        Logger.error(e)
        []
    end
  end

  def search(:users, q) do
    with {:ok, results} <- search(:raw, "users", "user", q) do
      results
      |> Enum.map(fn result -> result["_id"] end)
      |> Pleroma.User.get_all_by_ids()
    else
      e ->
        Logger.error(e)
        []
    end
  end

  def search(:hashtags, q) do
    with {:ok, results} <- search(:raw, "hashtags", "hashtag", q) do
      results
      |> Enum.map(fn result -> result["_source"]["hashtag"] end)
    else
      e ->
        Logger.error(e)
        []
    end
  end
end