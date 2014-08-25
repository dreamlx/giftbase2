require 'spec_helper'

describe Unit do
  let(:unit) { create(:unit)}

  subject { unit }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:exam_minutes)}
  it { should respond_to(:stage_id)}
  it { should respond_to(:position)}
  it { should respond_to(:image)}
  it { should respond_to(:question_groups)}
  it { should respond_to(:question_line_items)}
  it { should respond_to(:questions)}
  it { should respond_to(:exams)}
  it { should respond_to(:stage)}
  it { should respond_to(:user_unit)}
  it { should respond_to(:user)}
  it { should respond_to(:map_places)}
  it { should respond_to(:lock_state)}

  it { should be_valid}

  it "should be invalid without name" do
    build(:unit, name: nil).should be_invalid
  end

  it "should be invalid without exam_minutes" do
    build(:unit, exam_minutes: nil).should be_invalid
  end

  it "should be invalid without stage" do
    build(:unit, stage_id: nil).should be_invalid
  end

  it "belong_user" do
    user = create(:user)
    unit.belong_user(user).should eq UserUnit.first
  end

  it "unlock the user_unit with parameter user" do
    user = create(:user)
    user_unit = create(:user_unit, unit_id: unit.id, user_id: user.id)
    unit.unlock(user)
    user_unit.reload
    user_unit.state.should eq "unlock"
  end

  it "check if unlock user_unit with parameter user when state is lock" do
    user = create(:user)
    user_unit = create(:user_unit, unit_id: unit.id, user_id: user.id, state: "lock")
    unit.unlock?(user).should be_false
  end

  it "check if unlock user_unit with parameter user when state is unlock" do
    user = create(:user)
    user_unit = create(:user_unit, unit_id: unit.id, user_id: user.id, state: "unlock")
    unit.unlock?(user).should be_true
  end

  it "pre_question_line_item"
  it "next_question_line_item"
end