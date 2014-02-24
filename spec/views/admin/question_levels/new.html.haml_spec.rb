require 'spec_helper'

describe "admin/question_levels/new" do
  before(:each) do
    assign(:admin_question_level, stub_model(Admin::QuestionLevel).as_new_record)
  end

  it "renders new admin_question_level form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_question_levels_path, "post" do
    end
  end
end
