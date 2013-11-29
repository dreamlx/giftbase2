require 'spec_helper'

describe "Users" do
  it "should have the content 'Sign Up'" do
  	visit "/users/sign_up"
  	expect(page).to have_content('Sign')
  end
end
