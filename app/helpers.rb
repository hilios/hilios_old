helpers do
  include Sprockets::Helpers
  include Rack::Utils
  alias_method :h, :escape_html

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