defmodule SampleAppWeb.RouterHelper do
  def health_path, do: Application.get_env(:sample_app, SampleAppWeb.Endpoint)[:health_path]
end
