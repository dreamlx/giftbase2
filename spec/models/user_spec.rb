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
  it { should be_valid }
end