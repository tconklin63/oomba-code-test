require 'rails_helper'

RSpec.describe TeamsController do

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "renders the show template" do
      team = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
      get :show, params: {id: team.id}
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    it "renders the edit template" do
      team = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
      get :edit, params: {id: team.id}
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    it "creates a new team" do
      name = Faker::Team.creature
      post :create, params: {team: {name: name, description: Faker::Lorem.sentence}}
      expect(Team.find_by(name: name)).to_not be_nil
    end
  end

  describe "PUT update" do
    it "updates an existing team" do
      team = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
      new_name = Faker::Team.creature
      put :update, params: {id: team.id, team: {name: new_name, description: team.description}}
      expect(Team.find_by(name: new_name)).to_not be_nil
    end
  end

  describe "DELETE" do
    it "deletes an existing team" do
      team = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
      expect(Team.find_by(name: team.name)).to_not be_nil
      delete :destroy, params: {id: team.id}
      expect(Team.find_by(name: team.name)).to be_nil
    end
  end

end