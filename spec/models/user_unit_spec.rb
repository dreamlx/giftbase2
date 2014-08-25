require 'spec_helper'

describe UserUnit do
  let(:user_unit) { create(:user_unit)}

  subject { user_unit }
  it { should respond_to(:user_id)}
  it { should respond_to(:unit_id)}
  it { should respond_to(:state)}
  it { should be_valid}
end