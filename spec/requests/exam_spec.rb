require 'spec_helper'

describe 'take_exam_page' do
	# subject{ page }
	include ControllerMacros
	
	login_user

	# before do 
 #      @unit = Unit.find(16)
 #      visit unit_path(@unit)
	# end

	describe "next question_line_item" do

	  let(:next_submit){I18n.t("next_question_line_item")}
	  it "question_line_item's position should add one" do
        should have_content(I18n.t("app_name"))
        should have_content(I18n.t("signed_in", scope:"sessions"))
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
