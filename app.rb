require('bundler/setup')
require('pry')
Bundler.require(:default)
# set :erb, :escape_html => true
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# SHARED
# ------------------------------------

get('/reset') do
  Band.delete_all
  Venue.delete_all

  redirect to('/')
end

get('/') do
  @bands  = Band.all
  @venues = Venue.all
  erubis(:index)
end

# BANDS
# ------------------------------------

# Note: some routes are absent as the homepage combines several
# views into one

post('/bands') do
  @object = Band.new(name: params.fetch('band_name'))

  if @object.save
    redirect to('/')
  else
    erubis(:errors)
  end
end

get('/bands/:id') do
  @band            = Band.find(params.fetch('id').to_i)
  @previous_venues = @band.venues

  erubis(:band)
end

get('/bands/:id/edit') do
  @band   = Band.find(params.fetch('id').to_i)
  @previous_venues = @band.venue_ids
  @venues = Venue.all

  erubis(:band_edit)
end

patch('/bands/:id') do
  checkbox_values = params.fetch('checkbox_values', [])
  @object = Band.find(params.fetch('id').to_i)

  @object.venue_ids = checkbox_values

  if @object.update(name: params.fetch('name'))
    redirect back
  else
    erubis(:errors)
  end
end

delete('/bands/:id') do
  Band.find(params.fetch('id')).destroy
  redirect to('/')
end

# VENUES
# ------------------------------------

post('/venues') do
  @object = Venue.new(name: params.fetch('venue_name'))

  if @object.save
    redirect to('/')
  else
    erubis(:errors)
  end
end
