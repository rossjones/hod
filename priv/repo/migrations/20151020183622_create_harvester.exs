defmodule Harvest.Repo.Migrations.CreateHarvester do
  use Ecto.Migration

  def change do
    create table(:harvester) do
      add :name, :string
      add :type, :string
      add :status, :string
      add :config, :text
      add :last_run, :datetime
      add :user_id, references(:users)

      timestamps
    end

    create index(:harvester, [:user_id])

  end
end
