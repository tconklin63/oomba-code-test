class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:invite]

  def index
    if params[:search_param].blank?
      @teams = Team.all.order(name: :asc)
    else
      users      = User.where('name LIKE ?', "%#{params[:search_param]}%")
      teams      = Team.where('name LIke ?', "%#{params[:search_param]}%")
      teams_user = TeamsUser.where(user_id: users.pluck(:id)) + TeamsUser.where(team_id: teams.pluck(:id))
      @teams     = Team.where(id: teams_user.pluck(:team_id))
    end
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
    host = request.port == 80 ? request.host : request.host_with_port
    TeamMailer.invite(team, params[:name], params[:email], host).deliver_now
    redirect_to team
  end

  def accept
    @team  = Team.find(params[:id])
    @name  = params[:name]
    @email = params[:email]
  end

  def confirm
    team = Team.find(params[:id])
    user = User.find_or_create_by(email: params[:email])
    user.update_attribute('name', params[:name])
    team.users << user if !team.users.include?(user)
    redirect_to team
  end

  def remove_player
    team = Team.find(params[:id])
    user = User.find(params[:user_id])
    team.users.delete(user)
    redirect_to team
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
