require 'rack/jekyll'
run Rack::Jekyll.new

# static configuration (file path matches request path)
require 'rack/contrib/try_static'
use Rack::TryStatic,
  :root => "_site",  # static files root dir
  :urls => %w[/],    # match all requests
  :try => ['.html', 'index.html', '/index.html'], # try these postfixes sequentially
  :gzip => true,     # enable compressed files
  :header_rules => [
    [:all, {'Cache-Control' => 'public, max-age=86400'}],
    [['css', 'js'], {'Cache-Control' => 'public, max-age=604800'}]
  ]

# otherwise 404 NotFound
notFoundPage = File.open('_site/404.html').read
run lambda { |_| [404, {'Content-Type' => 'text/html'}, [notFoundPage]]}
