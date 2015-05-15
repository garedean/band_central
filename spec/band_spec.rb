require('spec_helper')

describe(Band) do
  it { should have_and_belong_to_many(:venues) }

  it { should validate_presence_of(:name) }

  it('capitalizes first character of name before save') do
    band = Band.create(name: "bon Iver")
    expect(Band.find(band.id).name).to(eq("Bon Iver"))
  end
end
