require 'spec_helper'

describe "Users" do
  
  describe "home#index click each role button" do
  	subject{page}
  	let(:sign_up){"Sign up"}
  	before{visit root_path}

  	describe "click student then click sign_up" do
  	  let(:submit_student){User.human_attribute_name(:student)}
  	  before do 
  	  	click_link submit_student
  	  	click_link sign_up
  	  end
  	  it " should be have user_role student" do
  	  	should have_content(User.human_attribute_name(:email))
  	  	should have_selector("input[value='student']")
      end
  	end

  	describe "click parents then click sign_up" do
  	  let(:submit_parents){User.human_attribute_name(:parents)}
  	  before do 
  	  	click_link submit_parents
  	  	click_link sign_up
  	  end
  	  it "should be have user_role parents" do
  	  	should have_selector("input[value='parents']")
      end
  	end
  end

end
