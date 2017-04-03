defmodule CompaShares.Repo.Migrations.AddImageUrlToShares do
  use Ecto.Migration

  def change do
    alter table(:shares) do
      add :image_url, :string
    end
  end
end
