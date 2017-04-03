defmodule CompaShares.ShareController do
  use CompaShares.Web, :controller

  alias CompaShares.Share
  alias CompaShares.Links

  def index(conn, _params) do
    shares = Repo.all(Share)
    render(conn, "index.html", shares: shares)
  end

  def new(conn, _params) do
    changeset = Share.changeset(%Share{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"share" => share_params}) do
    changeset = Share.changeset(%Share{}, share_params)

    case Repo.insert(changeset) do
      {:ok, _share} ->
        conn
        |> put_flash(:info, "Share created successfully.")
        |> redirect(to: share_path(conn, :index))
      {:error, changeset} ->
        changeset = %{changeset | action: :insert, errors: changeset.errors}
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)
    render(conn, "show.html", share: share)
  end

  def edit(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)
    changeset = Share.changeset(share)
    render(conn, "edit.html", share: share, changeset: changeset)
  end

  def update(conn, %{"id" => id, "share" => share_params}) do
    share = Repo.get!(Share, id)
    changeset = Share.changeset(share, share_params)

    case Repo.update(changeset) do
      {:ok, share} ->
        conn
        |> put_flash(:info, "Share updated successfully.")
        |> redirect(to: share_path(conn, :show, share))
      {:error, changeset} ->
        render(conn, "edit.html", share: share, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(share)

    conn
    |> put_flash(:info, "Share deleted successfully.")
    |> redirect(to: share_path(conn, :index))
  end

  def update_description(conn, %{"id" => id}) do
    share = Repo.get!(Share, id)

    body_html = share.link
       |> Links.get_link_body
    description =
      body_html
       |> Links.parse_meta_tag

    image_url =
      body_html
       |> Links.parse_og_image
    changeset = Share.changeset(share, %{description: description, image_url: image_url})

    case Repo.update(changeset) do
      {:ok, share} ->
        conn
        |> put_flash(:info, "Share updated successfully.")
        |> redirect(to: share_path(conn, :show, share))
      {:error, changeset} ->
        render(conn, "edit.html", share: share, changeset: changeset)
    end
  end
end
