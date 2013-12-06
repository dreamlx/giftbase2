require 'spec_helper'


describe 'take_exam_page' do
	subject{ page }

	before do 
	  @unit = Unit.find(15)
	  @question_line_item = @unit.question_line_items.order("position").first
	  visit take_exam_unit_path(@unit)
	end

	describe "next question_line_item" do
	  let(:submit){I18n.t("next_question_line_item")}
	  it "question_line_item's position should add one" do
	  	# expect{click_on submit}.to change{@question_line_item.position}.from(1).to(2)
	  end
	end

	describe "prev question_line_item" do
	end

	describe "submit all question_line_item" do
	end

end
