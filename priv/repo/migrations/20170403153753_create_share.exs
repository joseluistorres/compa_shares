defmodule CompaShares.Repo.Migrations.CreateShare do
  use Ecto.Migration

  def change do
    create table(:shares) do
      add :link, :string
      add :description, :string
      add :username, :string
      add :date_shared, :datetime

      timestamps()
    end

  end
end
