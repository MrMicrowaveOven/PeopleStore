class Person < ApplicationRecord
  # attr_accessor :name, :numbers
  validates :name, presence: true
  validates :numbers, presence: true
  def self.create_slash_update(params)
    new_numbers = params[:numbers]
    new_name = params[:name]
    person = Person.find_by_name(params[:name])
    p "=========================="
    p person
    p "**************************"
    if person
      person[:numbers] += " " + params[:numbers]
      person
    else
      Person.new(params)
    end
  end
end
