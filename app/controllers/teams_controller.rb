class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:invite]

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
    @team = Team.create(team_params)
    redirect_to @team
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    @team.update_attributes(team_params)
    redirect_to @team
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to :teams
  end

  def invite
    team = Team.find(params[:id])
    TeamMailer.invite(team, params[:name], params[:email], request.host).deliver_now
    redirect_to team
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
