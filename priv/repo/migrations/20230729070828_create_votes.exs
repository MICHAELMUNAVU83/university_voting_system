defmodule UniversityVotingSystem.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :contestant_id, references(:contestants, on_delete: :nothing), null: false
      add :position_id, references(:positions, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
