require 'spec_helper'

describe Stage do
  let(:stage) { create(:stage)}

  subject { stage }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:price)}
  it { should respond_to(:video)}
  it { should respond_to(:video_poster)}
  it { should respond_to(:grade_id)}
  it { should respond_to(:position)}
  it { should respond_to(:grade)}
  it { should respond_to(:units)}
  it { should respond_to(:exams)}
  it { should respond_to(:answers)}
  it { should respond_to(:map_places)}
  it { should respond_to(:user_stages)}
  it { should respond_to(:users)}
  it { should be_valid }


  it "should be invalid without a name" do
    build(:stage, name: nil).should be_invalid
  end

  it "should be valid without a description" do
    create(:stage, description: nil).should be_valid
  end

  it "should be invalid without a price" do
    build(:stage, price: nil).should be_invalid
  end

  it "should be valid without a video" do
    create(:stage, video: nil).should be_valid
  end

  it "should be valid without a video_poster" do
    create(:stage, video_poster: nil).should be_valid
  end

  it "should be invalid without a grade_id" do
    build(:stage, grade_id: nil).should be_invalid
  end

  it "should be valid without position" do
    create(:stage, position: nil).should be_valid
  end
end