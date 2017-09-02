require "rails_helper"

RSpec.describe TeamMailer, type: :mailer do

  describe 'invite' do
    let(:team) { Team.new(name: Faker::Team.creature, description: Faker::Lorem.sentence) }
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }
    let(:mail) { described_class.invite(team, name, email, 'localhost:3000').deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("You have been invited to join the #{team.name}")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'assigns @team_name' do
      expect(mail.body.encoded).to match(team.name)
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(name)
    end

    it 'assigns @url' do
      require 'uri'
      team.save
      team.reload
      host = 'localhost:3000'
      url  = URI.encode("http://#{host}/teams/#{team.id}/accept")
      expect(mail.body.encoded).to match(url)
    end

  end
end
