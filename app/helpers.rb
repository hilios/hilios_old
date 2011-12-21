helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  def asset_path(source)
    "/assets/#{settings.sprockets.find_asset(source).digest_path}"
  end
end