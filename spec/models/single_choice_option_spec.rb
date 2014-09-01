require 'spec_helper'

describe SingleChoiceOption do
  let(:single_choice_option) { create(:single_choice_option)}

  subject { single_choice_option }

  it { should respond_to(:question_id)}
  it { should respond_to(:content)}
  it { should respond_to(:position)}
  it { should respond_to(:sequence)}
  it { should respond_to(:correct)}
  it { should respond_to(:image)}
  it { should be_valid }


  it "should be invalid without a content" do
    build(:single_choice_option, content: nil).should be_invalid
  end
end