defmodule Dispatcher do
  use Matcher
  import Plug.Conn
  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    sparql: ["application/sparql-results+json",
             "application/sparql-results+xml",
             "text/csv",
             "application/ld+json",
             "application/rdf+xml",
             "text/turtle"
            ],
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  define_layers [ :static, :redirects, :sparql, :api_services, :frontend_fallback, :resources, :not_found ]

  # REDIRECTS
  # this is a quick hack because the frontend (metis) expects the true uri (with /id) but that goes to cool-uris.
  # another option is to have these view urls in the data
  get "/data/data-processing/activities/*uuid", %{ layer: :redirects, accept: %{ html: true } } do
    base_url = "https://stad.gent"
    resource_url = "#{base_url}/id/data-processing/activities/#{Enum.join(uuid, "/")}"
    encoded_resource = URI.encode_www_form(resource_url)
    redirect_url = "/data/view/verwerkings-activiteit?resource=#{encoded_resource}"

    conn
    |> put_resp_header("location", redirect_url)
    |> send_resp(302, "")
  end

 # frontend
  get "/data/assets/*path", %{ layer: :static } do
    forward conn, path, "http://frontend/data/assets/"
  end

  get "/data/@appuniversum/*path", %{ layer: :static } do
    forward conn, path, "http://frontend/data/@appuniversum/"
  end

  get "/data/index.html", %{ layer: :static } do
    forward conn, [], "http://frontend/data/index.html"
  end

  # get "/sparql", %{ layer: :static, accept: %{ html: true} } do
  #   forward conn, [], "http://frontend/index.html"
  # end

  # API SERVICES
  match "/resource-labels/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://resource-labels/"
  end

  get "/uri-info/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://uri-info/"
  end

  match "/conductor/*path", %{ layer: :sparql } do
    forward conn, path, "http://virtuoso:8890/conductor/"
  end

  match "/sparql/*path", %{ layer: :sparql } do
    forward conn, path, "http://virtuoso:8890/sparql/"
  end

  get "/data/view/*path", %{ layer: :static, accept: %{ html: true } } do
    forward conn, path, "http://frontend/data/"
  end

  match "/data/*path", %{ layer: :sparql } do
    forward conn, path, "http://virtuoso:8890/data/"
  end


 # fallback routes
  get "/*path", %{ layer: :frontend_fallback, accept: %{ html: true } } do
    # We forward path virtuoso
    forward conn, path, "http://virtuoso:8890/"
  end

  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
