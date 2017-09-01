class TeamsController < ApplicationController

  def index
    @teams = Team.all.order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    Team.create(team_params)
    redirect_to :teams #TODO: this should redirect to show
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    Team.find(params[:id]).update_attributes(team_params)
    redirect_to :teams #TODO: this should redirect to show
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to :teams
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
