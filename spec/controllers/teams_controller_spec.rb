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
    let(:name) { Faker::Team.creature }

    before(:each) do
      post :create, params: {team: {name: name, description: Faker::Lorem.sentence}}
    end

    it "creates a new team" do
      expect(Team.find_by(name: name)).to_not be_nil
    end

    it "redirects to show page" do
      expect(response).to redirect_to(Team.find_by(name: name))
    end
  end

  describe "PUT update" do
    let(:team) { Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence) }
    let(:new_name) { Faker::Team.creature }

    before(:each) do
      put :update, params: {id: team.id, team: {name: new_name, description: team.description}}
    end

    it "updates an existing team" do
      expect(team.reload).to_not be_nil
      expect(team.name).to eq(new_name)
    end

    it "redirects to show page" do
      expect(response).to redirect_to(team)
    end
  end

  describe "DELETE delete" do
    before(:each) do
      @team = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
    end

    it "deletes an existing team" do
      expect(Team.find_by(name: @team.name)).to_not be_nil
      delete :destroy, params: {id: @team.id}
      expect(Team.find_by(name: @team.name)).to be_nil
    end

    it "redirects to index page after delete" do
      delete :destroy, params: {id: @team.id}
      expect(response).to redirect_to(:teams)
    end
  end

  describe "POST invite" do
    it 'redirects to team page' do
      team  = Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
      name  = Faker::Name.name
      email = Faker::Internet.email
      post :invite, params: {id: team.id, name: name, email: email}
      expect(response).to redirect_to(team)
    end
  end

  describe "GET accept" do
    let(:team) { Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence) }
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }

    before(:each) do
      get :accept, params: {id: team.id, name: name, email: email}
    end

    it "renders the accept template" do
      expect(response).to render_template("accept")
    end

    it "assigns @name" do
      expect(assigns(:name)).to eq(name)
    end

    it "assigns @email" do
      expect(assigns(:email)).to eq(email)
    end
  end

  describe "POST confirm" do
    let(:team) { Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence) }
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }

    before(:each) do
      team.save
      team.reload
    end

    it 'creates new user' do
      post :confirm, params: {id: team.id, name: name, email: email}
      expect(User.find_by(email: email)).to_not be_nil
    end

    it 'updates existing user' do
      user = User.create(email: email, name: Faker::Name.name)
      post :confirm, params: {id: team.id, name: name, email: email}
      expect(User.find_by(email: email).name).to eq(name)
    end

    it 'creates association between game and user' do
      post :confirm, params: {id: team.id, name: name, email: email}
      expect(team.reload.users).to eq([User.find_by(email: email)])
    end

    it 'is idempotent (adds user to team only once)' do
      post :confirm, params: {id: team.id, name: name, email: email}
      post :confirm, params: {id: team.id, name: name, email: email}
      expect(team.reload.users).to eq([User.find_by(email: email)])
    end

    it 'redirects to team page' do
      post :confirm, params: {id: team.id, name: name, email: email}
      expect(response).to redirect_to(team)
    end

  end

end