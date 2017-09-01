class TeamsController < ApplicationController

  def index
    @teams = Team.all.order(name: :asc)
  end

end
