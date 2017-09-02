class UsersController < ApplicationController

  def index
    @users = User.all.order(name: :asc)
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :users
  end

end
