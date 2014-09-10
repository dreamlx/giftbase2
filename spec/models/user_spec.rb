require 'spec_helper'

describe User do
  let(:user) { create(:user)}

  subject { user }

  it { should respond_to(:email)}
  it { should respond_to(:sign_in_count)}
  it { should respond_to(:role)}
  it { should respond_to(:avatar)}
  it { should respond_to(:gender)}
  it { should respond_to(:username)}
  it { should respond_to(:avatar_id)}
  it { should respond_to(:birthday)}
  it { should respond_to(:home_address)}
  it { should respond_to(:school_name)}
  it { should respond_to(:school_address)}
  it { should respond_to(:qq)}
  it { should respond_to(:parent_name)}
  it { should respond_to(:phone)}
  it { should respond_to(:unconfirmed_email)}
  it { should respond_to(:class_no)}
  it { should respond_to(:user_questions)}
  it { should respond_to(:questions)}
  it { should respond_to(:exams)}
  it { should respond_to(:user_units)}
  it { should respond_to(:units)}
  it { should respond_to(:user_stages)}
  it { should respond_to(:stages)}
  it { should respond_to(:user_grades)}
  it { should respond_to(:grades)}
  it { should respond_to(:credit)}
  it { should respond_to(:orders)}
  it { should respond_to(:child_parents)}
  it { should respond_to(:children)}
  it { should respond_to(:reverse_child_parents)}
  it { should respond_to(:parents)}
  it { should respond_to(:scores)}
  
  it { should be_valid }

  it "should be invalid without email" do
    build(:user, email: nil).should be_invalid
  end

  it "should be invalid without password" do
    build(:user, password: nil).should be_invalid
  end
end