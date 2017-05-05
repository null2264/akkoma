defmodule HTTPoisonMock do
  alias HTTPoison.Response

  def get(url, body \\ [], headers \\ [])

  def get("https://social.heldscal.la/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "nonexistant@social.heldscal.la"]]) do
    {:ok, %Response{
      status_code: 500,
      body: File.read!("test/fixtures/httpoison_mock/nonexistant@social.heldscal.la.xml")
    }}
  end

  def get("https://social.heldscal.la/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "shp@social.heldscal.la"]]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/shp@social.heldscal.la.xml")
    }}
  end
  
  def get("https://social.heldscal.la/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "https://social.heldscal.la/user/23211"]]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___social.heldscal.la_user_23211.xml")
    }}
  end
  
  def get("https://social.heldscal.la/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "https://social.heldscal.la/user/29191"]]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___social.heldscal.la_user_29191.xml")
    }}
  end

  def get("https://mastodon.social/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "https://mastodon.social/users/lambadalambda"]]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___mastodon.social_users_lambadalambda.xml")
    }}
  end

  def get("http://gs.example.org/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "http://gs.example.org:4040/index.php/user/1"], follow_redirect: true]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/http___gs.example.org_4040_index.php_user_1.xml")
    }}
  end

  def get("https://pleroma.soykaf.com/.well-known/webfinger", [Accept: "application/xrd+xml"], [params: [resource: "https://pleroma.soykaf.com/users/lain"]]) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___pleroma.soykaf.com_users_lain.xml")
    }}
  end

  def get("https://social.heldscal.la/api/statuses/user_timeline/29191.atom", _body, _headers) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___social.heldscal.la_api_statuses_user_timeline_29191.atom.xml")
    }}
  end

  def get("https://social.heldscal.la/api/statuses/user_timeline/23211.atom", _body, _headers) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___social.heldscal.la_api_statuses_user_timeline_23211.atom.xml")
    }}
  end

  def get("https://mastodon.social/users/lambadalambda.atom", _body, _headers) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___mastodon.social_users_lambadalambda.atom")
    }}
  end

  def get("https://pleroma.soykaf.com/users/lain/feed.atom", _body, _headers) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/https___pleroma.soykaf.com_users_lain_feed.atom.xml")
    }}
  end

  def get("http://gs.example.org/index.php/api/statuses/user_timeline/1.atom", _body, _headers) do
    {:ok, %Response{
      status_code: 200,
      body: File.read!("test/fixtures/httpoison_mock/http__gs.example.org_index.php_api_statuses_user_timeline_1.atom.xml")
    }}
  end

  def get(url, body, headers) do
    {:error, "Not implemented the mock response for get #{inspect(url)}"}
  end

  def post(url, body, headers) do
    {:error, "Not implemented the mock response for post #{inspect(url)}"}
  end
end
