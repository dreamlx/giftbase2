require 'spec_helper'

describe "admin/question_levels/edit" do
  before(:each) do
    @admin_question_level = assign(:admin_question_level, stub_model(Admin::QuestionLevel))
  end

  it "renders the edit admin_question_level form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_question_level_path(@admin_question_level), "post" do
    end
  end
end
