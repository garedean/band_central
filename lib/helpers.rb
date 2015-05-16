# Titleize
helpers do
  def title(text)
    "<h1 class='page-heading text-center'>#{text}</h1>"
  end
end

# Escape HTML in views
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end
