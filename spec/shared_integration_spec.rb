ENV['RACK_ENV'] = 'test'
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the /reset path', type: :feature) do
  it('resets all data on the site') do
    Band.create(name: 'Horsefeathers')
    Venue.create(name: 'Portland')
    visit('/')
    expect(page).to(have_content('Horsefeathers'))
    expect(page).to(have_content('Portland'))
    click_link('Reset')
    expect(page).to_not(have_content('Horsefeathers'))
    expect(page).to_not(have_content('Portland'))
  end
end
