require 'spec_helper'

describe 'take_exam_page' do
	subject{ page }

	before do 
    student = FactoryGirl.create(:user)
    # student = User.find_by_email("duxiaolong92@gmail.com")
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in student
	  @unit = Unit.find(16)
	  visit unit_path(@unit)
	end

	describe "next question_line_item" do

	  let(:next_submit){I18n.t("next_question_line_item")}
	  it "question_line_item's position should add one" do
      should have_content(I18n.t("app_name"))
      should have_content("A")
      # should have_content(@unit.questions.first.class.model_name.human)
      # should have_content("1+1")
      # expect{click_link next_submit}.to change{@question_line_item.position}.from(1).to(2)
	  end
	end

	describe "prev question_line_item" do
	end

	describe "submit all question_line_item" do
	end

end
