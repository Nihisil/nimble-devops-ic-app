Code.put_compiler_option(:warnings_as_errors, true)

{:ok, _} = Application.ensure_all_started(:mimic)

{:ok, _} = Application.ensure_all_started(:ex_machina)

Mimic.copy(Ecto.Adapters.SQL)

{:ok, _} = Application.ensure_all_started(:wallaby)

ExUnit.start(capture_log: true)
Ecto.Adapters.SQL.Sandbox.mode(SampleApp.Repo, :manual)

Application.put_env(:wallaby, :base_url, SampleAppWeb.Endpoint.url())
