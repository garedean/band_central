require('spec_helper')

describe(Venue) do
  it { should have_and_belong_to_many(:bands) }

  it { should validate_presence_of(:name) }

  it('capitalizes first character of name before save') do
    venue = Venue.create(name: "berlin")
    expect(Venue.find(venue.id).name).to(eq("Berlin"))
  end
end
