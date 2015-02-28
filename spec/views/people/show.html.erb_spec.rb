require 'rails_helper'

RSpec.describe "people/show", type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
      :first_name => "Jane",
      :last_name => "Doe"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Jane/)
    expect(rendered).to match(/Doe/)
  end
end
