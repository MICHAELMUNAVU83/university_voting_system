defmodule UniversityVotingSystem.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
