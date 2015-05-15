ENV['RACK_ENV'] = 'test'
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the Band Central app', type: :feature) do
  it('adds a venue and displays it on the home page') do
    visit('/')
    fill_in('venue_name', with: 'berlin')
    click_button('Add Venue')
    expect(page).to(have_content('Berlin'))
  end

  it("lists all venues on home page") do
    Venue.create(name: 'Madison, WI')
    Venue.create(name: 'Berlin, DE')
    Venue.create(name: 'Paris, FR')

    visit("/")
    expect(page).to(have_content("Madison, WI"))
    expect(page).to(have_content("Berlin, DE"))
    expect(page).to(have_content("Paris, FR"))
  end

  it("lists all venues on the '/bands/:id' path") do
    Venue.create(name: 'Madison, WI')
    Venue.create(name: 'Berlin, DE')
    Venue.create(name: 'Paris, FR')
    band = Band.create(name: 'Bon Iver')

    visit("/bands/#{band.id}/edit")
    expect(page).to(have_content("Madison, WI"))
    expect(page).to(have_content("Berlin, DE"))
    expect(page).to(have_content("Paris, FR"))
  end

  it("shows a message on the '/band/:id/edit' path when no venues exist") do
    band = Band.create(name: 'Bon Iver')

    visit("/bands/#{band.id}/edit")
    expect(page).to(have_content("To assign a venue to this band, you'll need to add one first."))
  end

  it("shows a message on the '/band/:id' path when the band has not been assigned any venues") do
    band = Band.create(name: 'Bon Iver')

    visit("/bands/#{band.id}")
    expect(page).to(have_content("This band hasn't been assign any previous venues."))
  end
end
