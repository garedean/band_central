class Venue < ActiveRecord::Base
  before_save(:title_case)
  has_and_belongs_to_many(:bands)
  validates(:name, presence: true)

  private

  define_method(:title_case) do
    self.name = name[0].upcase + name[1..-1]
  end
end
