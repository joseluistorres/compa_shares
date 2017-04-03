defmodule CompaShares.ShareControllerTest do
  use CompaShares.ConnCase

  alias CompaShares.Share
  @valid_attrs %{description: "some content", link: "some content", username: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, share_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing shares"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, share_path(conn, :new)
    assert html_response(conn, 200) =~ "New share"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, share_path(conn, :create), share: @valid_attrs
    assert redirected_to(conn) == share_path(conn, :index)
    assert Repo.get_by(Share, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, share_path(conn, :create), share: @invalid_attrs
    assert html_response(conn, 200) =~ "New share"
  end

  test "shows chosen resource", %{conn: conn} do
    share = Repo.insert! %Share{}
    conn = get conn, share_path(conn, :show, share)
    assert html_response(conn, 200) =~ "Show share"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, share_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    share = Repo.insert! %Share{}
    conn = get conn, share_path(conn, :edit, share)
    assert html_response(conn, 200) =~ "Edit share"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    share = Repo.insert! %Share{}
    conn = put conn, share_path(conn, :update, share), share: @valid_attrs
    assert redirected_to(conn) == share_path(conn, :show, share)
    assert Repo.get_by(Share, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    share = Repo.insert! %Share{}
    conn = put conn, share_path(conn, :update, share), share: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit share"
  end

  test "deletes chosen resource", %{conn: conn} do
    share = Repo.insert! %Share{}
    conn = delete conn, share_path(conn, :delete, share)
    assert redirected_to(conn) == share_path(conn, :index)
    refute Repo.get(Share, share.id)
  end
end
