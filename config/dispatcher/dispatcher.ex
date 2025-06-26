defmodule Dispatcher do
  use Matcher
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


  define_layers [ :static, :sparql, :api_services, :frontend_fallback, :resources, :not_found ]

 # frontend
  get "/assets/*path", %{ layer: :static } do
    forward conn, path, "http://frontend/assets/"
  end

  get "/index.html", %{ layer: :static } do
    forward conn, [], "http://frontend/index.html"
  end

  get "/sparql", %{ layer: :static, accept: %{ html: true} } do
    forward conn, [], "http://frontend/index.html"
  end

  # API SERVICES
  match "/resource-labels/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://resource-labels/"
  end

  get "/uri-info/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://uri-info/"
  end

  match "/sparql/*path", %{ layer: :sparql, accept: %{ sparql: true} } do
    forward conn, path, "http://sparqlproxy/sparql/"
  end

 # fallback routes
  get "/*path", %{ layer: :frontend_fallback, accept: %{ html: true } } do
    # We forward path for fastboot
    forward conn, path, "http://frontend/"
  end

  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
