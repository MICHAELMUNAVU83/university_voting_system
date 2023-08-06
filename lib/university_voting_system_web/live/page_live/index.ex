defmodule UniversityVotingSystemWeb.PageLive.Index do
  use UniversityVotingSystemWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end
end
