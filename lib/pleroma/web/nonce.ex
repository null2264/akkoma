# Pleroma: A lightweight social networking server
# Copyright © 2017-2021 Pleroma Authors <https://pleroma.social/>
# SPDX-License-Identifier: AGPL-3.0-only

defmodule Pleroma.Web.Nonce do
  alias Phoenix.HTML

  def build_tag(%{assigns: %{csp_nonce: nonce}}) do
    if Pleroma.Config.get([:instance, :provide_nonce]) do
      build_script_tag("window['__akkomaNonce'] = '#{nonce}'", nonce)
    else
      ""
    end
  end

  def build_script_tag(content, nonce) do
    HTML.Tag.content_tag(:script, HTML.raw(content),
      type: "application/json",
      nonce: nonce
    )
  end
end
