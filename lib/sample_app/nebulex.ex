defmodule SampleApp.RedisCache do
  @cache_adapter Application.compile_env!(:sample_app, :cache_adapter)

  use Nebulex.Cache,
    otp_app: :sample_app,
    adapter: @cache_adapter
end
