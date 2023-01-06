defmodule SampleAppWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature
      use Mimic

      import SampleApp.Factory
      import SampleAppWeb.Gettext

      alias SampleApp.Repo
      alias SampleAppWeb.Endpoint
      alias SampleAppWeb.Router.Helpers, as: Routes

      @moduletag :feature_test
    end
  end
end
