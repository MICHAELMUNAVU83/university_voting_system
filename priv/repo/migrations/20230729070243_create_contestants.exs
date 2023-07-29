defmodule UniversityVotingSystem.Repo.Migrations.CreateContestants do
  use Ecto.Migration

  def change do
    create table(:contestants) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :position_id, references(:positions, on_delete: :nothing), null: false
      add :approved, :boolean, default: false

      timestamps()
    end
  end
end
