require 'spec_helper'

describe Score do
  let(:score) { create(:score)}

  subject { score }

  it { should respond_to(:user)}
  it { should respond_to(:user_id)}
  it { should respond_to(:number)}

  it { should be_valid }

  it "should be invalid without user" do
  	build(:score, user: nil).should be_invalid
  end

  it "should be invalid without number" do
  	build(:score, number: nil).should be_invalid
  end
end
