require 'spec_helper'

describe "admin/question_levels/show" do
  before(:each) do
    @admin_question_level = assign(:admin_question_level, stub_model(Admin::QuestionLevel))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
