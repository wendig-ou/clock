require 'json'

app = Proc.new do |env|
  body = JSON.dump('time' => Time.now)
  [200, {'content-type' => 'application/json'}, [body]]
end

# Without this line, the rack app won't service the files in the public
# directory by itself. If commented out, the current time in JSON format will be
# returned for all requests. You can also make your webserver (apache, nginx
# etc.) serve the public directory. See
# https://wendig.io/2019/06/12/how-to-host-a-ruby-on-rails-app-with-apache.html
# for details
use Rack::Static, urls: {'/' => 'index.html', '/style.css' => 'style.css'}, root: 'public'

run app
