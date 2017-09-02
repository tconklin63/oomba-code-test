require 'rails_helper'

RSpec.describe UsersController do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "DELETE destroy" do
    let(:user) { User.create(name: Faker::Name.name, email: Faker::Internet.email) }

    it "deletes an existing user" do
      expect(User.find_by(name: user.name)).to_not be_nil
      delete :destroy, params: {id: user.id}
      expect(User.find_by(name: user.name)).to be_nil
    end

    it "redirects to index page after delete" do
      delete :destroy, params: {id: user.id}
      expect(response).to redirect_to(:users)
    end
  end

end