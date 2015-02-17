require "rails_helper"

RSpec.describe UrlsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/urls").to route_to("urls#index")
    end

    it "routes to #new" do
      expect(:get => "/urls/new").to route_to("urls#new")
    end

    it "routes to #show" do
      expect(:get => "/urls/1").to route_to("urls#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/urls").to route_to("urls#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/urls/1").to route_to("urls#destroy", :id => "1")
    end

    it "routes to #go" do
      expect(:get => "/urls/go/arndi1").to route_to("urls#go", :short => "arndi1")
    end

    it "does NOT route to #edit" do
      expect(:get => "/urls/1/edit").not_to be_routable
    end

    it "does NOT route to #update" do
      expect(:put => "/urls/1").not_to be_routable
    end

  end
end
