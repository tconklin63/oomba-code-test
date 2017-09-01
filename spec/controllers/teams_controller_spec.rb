require 'rails_helper'

RSpec.describe TeamsController do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a new team" do
      name = Faker::Team.creature
      post :create, params: {team: {name: name, description: Faker::Lorem.sentence}}
      expect(Team.find_by(name: name)).to_not be_nil
    end
  end

end