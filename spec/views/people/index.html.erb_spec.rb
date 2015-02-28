require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        :first_name => "Jane",
        :last_name => "Doe"
      ),
      Person.create!(
        :first_name => "Jane",
        :last_name => "Doe"
      )
    ])
  end

  it "renders a list of people" do
    render
    assert_select "tr>td", :text => "Jane".to_s, :count => 2
    assert_select "tr>td", :text => "Doe".to_s, :count => 2
  end
end
