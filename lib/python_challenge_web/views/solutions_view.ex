defmodule PythonChallengeWeb.SolutionsView do
  use PythonChallengeWeb, :view

  import Phoenix.Controller, only: [get_csrf_token: 0]

  alias PythonChallengeWeb.ChallengeView
end
