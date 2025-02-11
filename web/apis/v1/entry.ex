defmodule MediaSample.API.V1.Entry do
  use Maru.Router
  import Phoenix.View, only: [render: 3], warn: false
  alias MediaSample.{Repo, Entry, API.EntryView}, warn: false
  helpers MediaSample.API.V1.SharedParams

  resource "/entries" do
    params do
      use [:page]
    end
    get "/" do
      page = Entry |> Entry.preload_all(conn.assigns.locale) |> Repo.slave.paginate(Guardian.Utils.stringify_keys(params))
      conn
      |> Scrivener.Headers.paginate(page)
      |> json(render(EntryView, "index.json", entries: page.entries))
    end
  end
end
