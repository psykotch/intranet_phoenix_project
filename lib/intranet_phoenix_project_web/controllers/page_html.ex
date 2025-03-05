defmodule IntranetPhoenixProjectWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use IntranetPhoenixProjectWeb, :html

  embed_templates "page_html/*"
end
