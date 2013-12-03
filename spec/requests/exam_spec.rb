require 'spec_helper'

describe 'exam_page' do
  describe 'take_exam_page' do
  	subject{ page }

  	before do 
  	  @unit = Unit.first
  	  @question_line_item = @unit.question_line_items.order("position").last
  	  visit take_exam_unit_path(@unit)
  	end


  	describe "next question_line_item" do
  	  let(:submit){I18n.t("next_question_line_item")}
  	  it "question_line_item's position should add one" do
  	  	# @next_question_line_item = @unit.next_question_line_item(@question_line_item.position)
  	  	# @next_question_line_item.position.should == @question_line_item.position
  	  	expect{click_on submit}.to change{@question_line_item.position}.from(1).to(2)
  	  end
  	  # it{should have_content("Unit.next_question_line_item(@unit.position)")}
  	end

  	describe "prev question_line_item" do
  	end

  	describe "submit all question_line_item" do
  	end

  end
end