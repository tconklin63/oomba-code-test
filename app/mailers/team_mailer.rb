class TeamMailer < ApplicationMailer

  def invite(team, name, email)
    @team_name = team.name
    @name      = name
    @url       = 'http://example.com/accept' #Fix this once it is implemented
    mail(to: email, subject: "You have been invited to join the #{@team_name}")
  end

end
