require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :question => "MyText",
        :answer => "Answer"
      ),
      Question.create!(
        :question => "MyText",
        :answer => "Answer"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Answer".to_s, :count => 2
  end
end
