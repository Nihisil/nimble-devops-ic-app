defmodule SampleAppWeb.HomePage.ViewHomePageTest do
  use SampleAppWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(SampleAppWeb.Endpoint, :index))

    assert_has(session, Query.text("Hi there!"))
  end
end
