defmodule CompaShares.Share do
  use CompaShares.Web, :model

  schema "shares" do
    field :link, :string
    field :description, :string
    field :username, :string
    field :date_shared, Ecto.DateTime
    field :image_url

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:link, :description, :username, :date_shared, :image_url])
    |> validate_required([:link, :username, :date_shared])
  end
end
