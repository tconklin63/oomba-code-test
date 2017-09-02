class TeamMailer < ApplicationMailer

  def invite(team, name, email, host='localhost:3000')
    require 'uri'
    @team_name = team.name
    @name      = name
    @url       = URI.encode("http://#{host}/teams/#{team.id}/accept?name=#{name}&email=#{email}")
    mail(to: email, subject: "You have been invited to join the #{@team_name}")
  end

end
