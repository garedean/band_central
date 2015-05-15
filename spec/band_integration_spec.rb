ENV['RACK_ENV'] = 'test'
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the Band Central app', type: :feature) do
  it('adds a band and displays it on the home page') do
    visit('/')
    fill_in('band_name', with: 'Bon Iver')
    click_button('Add Band')
    expect(page).to(have_content('Bon Iver'))
  end

  it("lists all bands on home page") do
    Band.create(name: 'Michael Jackson')
    Band.create(name: 'Miley Cyrus')
    Band.create(name: 'Justin Vernon')

    visit("/")
    expect(page).to(have_content("Michael Jackson"))
    expect(page).to(have_content("Miley Cyrus"))
    expect(page).to(have_content("Justin Vernon"))
  end

  it('updates a band name') do
    band = Band.create(name: 'Prince')
    visit("/bands/#{band.id}/edit")
    fill_in('name', with: 'The Artist Formerly Known as Prince')
    click_button('Update')
    click_link('Home')
    expect(page).to(have_content('The Artist Formerly Known as Prince'))
  end

  it('deletes a band') do
    Band.create(name: 'Prince')
    visit('/')
    fill_in('band_name', with: 'Bon Iver')
    click_button('Delete')
    expect(page).not_to(have_content('Bon Iver'))
  end

  it('assigns a venue to a band, shows assigned venues on band page') do
    Venue.create(name: 'Madison, WI')
    Venue.create(name: 'Berlin, DE')
    Venue.create(name: 'Paris, FR')
    band = Band.create(name: 'Bon Iver')

    visit("/bands/#{band.id}/edit")
    first("input[type='checkbox']").set(true)
    click_button('Update')

    click_link('Home')
    click_link('Bon Iver')
    expect(page).to(have_content("Madison, WI"))
  end
end
