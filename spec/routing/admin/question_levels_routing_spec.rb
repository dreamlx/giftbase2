require "spec_helper"

describe Admin::QuestionLevelsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/question_levels").should route_to("admin/question_levels#index")
    end

    it "routes to #new" do
      get("/admin/question_levels/new").should route_to("admin/question_levels#new")
    end

    it "routes to #show" do
      get("/admin/question_levels/1").should route_to("admin/question_levels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/question_levels/1/edit").should route_to("admin/question_levels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/question_levels").should route_to("admin/question_levels#create")
    end

    it "routes to #update" do
      put("/admin/question_levels/1").should route_to("admin/question_levels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/question_levels/1").should route_to("admin/question_levels#destroy", :id => "1")
    end

  end
end
