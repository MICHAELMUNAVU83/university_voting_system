defmodule UniversityVotingSystemWeb.PageController do
  use UniversityVotingSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
