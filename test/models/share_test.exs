defmodule CompaShares.ShareTest do
  use CompaShares.ModelCase

  alias CompaShares.Share

  @valid_attrs %{description: "some content", link: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Share.changeset(%Share{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Share.changeset(%Share{}, @invalid_attrs)
    refute changeset.valid?
  end
end
