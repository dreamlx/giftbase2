FactoryGirl.define do
  factory :post do
    image File.open(File.join(Rails.root, 'spec/fixtures/images/rails.png')) 
  end
end