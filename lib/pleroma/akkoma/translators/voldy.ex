defmodule Pleroma.Akkoma.Translators.Voldy do
  @behaviour Pleroma.Akkoma.Translator

  #alias Pleroma.Config
  alias Pleroma.HTTP
  require Logger

  defp base_url() do
    # Require browser-like user-agent
    "https://translate.googleapis.com/translate_a/single?client=gtx&dt=t"
  end

  # TODO: Use later
  #defp base_url(:clients5) do
  #  "https://clients5.google.com/translate_a/t?client=dict-chrome-ex"
  #end

  defp random_user_agent() do
    Enum.random([
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36", # 13.5%
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36", # 6.6%
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:94.0) Gecko/20100101 Firefox/94.0", # 6.4%
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101 Firefox/95.0", # 6.2%
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36", # 5.2%
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36", # 4.8%
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36",
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148",
      "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1"
    ])
  end

  @impl Pleroma.Akkoma.Translator
  def languages do
    # https://cloud.google.com/translate/docs/languages
    languages = Enum.map(%{
      "Afrikaans" => "af",
      "Albanian" => "sq",
      "Amharic" => "am",
      "Arabic" => "ar",
      "Armenian" => "hy",
      "Azerbaijani" => "az",
      "Basque" => "eu",
      "Belarusian" => "be",
      "Bengali" => "bn",
      "Bosnian" => "bs",
      "Bulgarian" => "bg",
      "Catalan" => "ca",
      "Cebuano" => "ceb",
      "Chinese (Simplified)" => "zh-CN",
      "Chinese (Traditional)" => "zh-TW",
      "Corsican" => "co",
      "Croatian" => "hr",
      "Czech" => "cs",
      "Danish" => "da",
      "Dutch" => "nl",
      "English" => "en",
      "Esperanto" => "eo",
      "Estonian" => "et",
      "Finnish" => "fi",
      "French" => "fr",
      "Frisian" => "fy",
      "Galician" => "gl",
      "Georgian" => "ka",
      "German" => "de",
      "Greek" => "el",
      "Gujarati" => "gu",
      "Haitian Creole" => "ht",
      "Hausa" => "ha",
      "Hawaiian" => "haw",
      "Hebrew" => "he",
      "Hindi" => "hi",
      "Hmong" => "hmn",
      "Hungarian" => "hu",
      "Icelandic" => "is",
      "Igbo" => "ig",
      "Indonesian" => "id",
      "Irish" => "ga",
      "Italian" => "it",
      "Japanese" => "ja",
      "Javanese" => "jw",
      "Kannada" => "kn",
      "Kazakh" => "kk",
      "Khmer" => "km",
      "Korean" => "ko",
      "Kurdish" => "ku",
      "Kyrgyz" => "ky",
      "Lao" => "lo",
      "Latin" => "la",
      "Latvian" => "lv",
      "Lithuanian" => "lt",
      "Luxembourgish" => "lb",
      "Macedonian" => "mk",
      "Malagasy" => "mg",
      "Malay" => "ms",
      "Malayalam" => "ml",
      "Maltese" => "mt",
      "Maori" => "mi",
      "Marathi" => "mr",
      "Mongolian" => "mn",
      "Myanmar (Burmese)" => "my",
      "Nepali" => "ne",
      "Norwegian" => "no",
      "Nyanja (Chichewa)" => "ny",
      "Odia (Oriya)" => "or",
      "Pashto" => "ps",
      "Persian" => "fa",
      "Polish" => "pl",
      "Portuguese" => "pt",
      "Punjabi" => "pa",
      "Romanian" => "ro",
      "Russian" => "ru",
      "Samoan" => "sm",
      "Scots Gaelic" => "gd",
      "Serbian" => "sr",
      "Sesotho" => "st",
      "Shona" => "sn",
      "Sindhi" => "sd",
      "Sinhala (Sinhalese)" => "si",
      "Slovak" => "sk",
      "Slovenian" => "sl",
      "Somali" => "so",
      "Spanish" => "es",
      "Sundanese" => "su",
      "Swahili" => "sw",
      "Swedish" => "sv",
      "Filipino (Tagalog)" => "tl",
      "Tajik" => "tg",
      "Tamil" => "ta",
      "Telugu" => "te",
      "Thai" => "th",
      "Turkish" => "tr",
      "Ukrainian" => "uk",
      "Urdu" => "ur",
      "Uzbek" => "uz",
      "Vietnamese" => "vi",
      "Welsh" => "cy",
      "Xhosa" => "xh",
      "Yiddish" => "yi",
      "Yoruba" => "yo",
      "Zulu" => "zu",
    }, fn {k, v} -> %{code: v, name: k} end)
    {:ok, languages, languages}
  end

  @impl Pleroma.Akkoma.Translator
  def translate(string, from_language, to_language) do
    with {:ok, %{status: 200} = response} <- do_request(string, from_language, to_language),
         {:ok, body} <- Jason.decode(response.body) do

      {:ok, Enum.at(body, 2), Enum.at(body, 0) |> Enum.map(&List.first(&1)) |> Enum.join("")}
    else
      {:ok, %{status: status} = response} ->
        Logger.warning("Voldy: Request rejected: #{inspect(response)}")
        {:error, "Voldy request failed (code #{status})"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp do_request(string, from_language, to_language) do
    HTTP.get(
      base_url() <> "&" <> URI.encode_query(
        %{
          q: string,
          tl: to_language,
        }
        |> maybe_add_source(from_language),
        :rfc3986
      ),
      [
        {"content-type", "application/json"},
        {"user-agent", random_user_agent()}
      ]
    )
  end

  defp maybe_add_source(opts, nil), do: Map.put(opts, :sl, "auto")
  defp maybe_add_source(opts, lang), do: Map.put(opts, :sl, lang)
end
