require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new(name: Faker::Name.name, email: Faker::Internet.email) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a badly formatted email" do
    subject.email = 'badly.formatted.email'
    expect(subject).to_not be_valid
  end

  it "is not valid if email is not unique" do
    subject.save!
    duplicate_email = User.new(name: Faker::Name.name, email: subject.email)
    expect(duplicate_email).to_not be_valid
  end

  it "can add a user to multiple teams" do
    subject.save!
    subject.teams << Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
    subject.teams << Team.create(name: Faker::Team.creature, description: Faker::Lorem.sentence)
    expect(subject.reload.teams.count).to eq(2)
  end

end
