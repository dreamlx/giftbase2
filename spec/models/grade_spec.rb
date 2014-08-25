require 'spec_helper'

describe Grade do
  let(:grade) { create(:grade)}

  subject { grade }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:position)}
  it { should respond_to(:state)}
  it { should respond_to(:stages)}
  it { should respond_to(:units)}
  it { should respond_to(:exams)}
  it { should respond_to(:answers)}
  it { should respond_to(:pictures)}
  it { should respond_to(:user_grades)}
  it { should respond_to(:users)}
  it { should be_valid }


  it "should be valid without a name" do
    create(:grade, name: nil).should be_valid
  end

  it "should be valid without a description" do
    create(:grade, description: nil).should be_valid
  end

  it "should be valid without a position" do
    create(:grade, position: nil).should be_valid
  end

  it "should be valid without a state" do
    create(:grade, state: nil).should be_valid
  end
end