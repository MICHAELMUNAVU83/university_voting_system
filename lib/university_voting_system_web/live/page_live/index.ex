defmodule UniversityVotingSystemWeb.PageLive.Index do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end
end
