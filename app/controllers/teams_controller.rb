class TeamsController < ApplicationController

  def index
    @teams = Team.all.order(name: :asc)
  end

  def new
    @team = Team.new
  end

  def create
    Team.create(team_params)
    redirect_to :teams
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
