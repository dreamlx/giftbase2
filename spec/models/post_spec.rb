require 'spec_helper'

describe Post do
  let(:post) { create(:post)}

  subject { post }
  it { should respond_to(:image)}

  it { should be_valid }
end
