defmodule UniversityVotingSystem.Repo do
  use Ecto.Repo,
    otp_app: :university_voting_system,
    adapter: Ecto.Adapters.MyXQL
end
