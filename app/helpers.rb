helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def asset_path(source)
    "/assets/#{settings.sprockets.find_asset(source).digest_path}"
  end

  def stylesheet(*sources)
    sources.map do |source|
      source = "#{source}.css" if source.is_a? Symbol
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"#{asset_path(source)}\" />"
    end.join("\n")
  end

  def javascript(*sources)
    sources.map do |source|
      source = "#{source}.js" if source.is_a? Symbol
      "<script src=\"#{asset_path(source)}\" type=\"text/javascript\"></script>"
    end.join("\n")
  end
end