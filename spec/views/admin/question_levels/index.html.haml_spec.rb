require 'spec_helper'

describe "admin/question_levels/index" do
  before(:each) do
    assign(:admin_question_levels, [
      stub_model(Admin::QuestionLevel),
      stub_model(Admin::QuestionLevel)
    ])
  end

  it "renders a list of admin/question_levels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
