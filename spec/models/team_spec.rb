require 'rails_helper'

RSpec.describe Team, :type => :model do
  subject { described_class.new(name: Faker::Team.creature, description: Faker::Lorem.sentence) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if name is not unique" do
    subject.save!
    duplicate_team = Team.new(name: subject.name, description: Faker::Lorem.sentence)
    expect(duplicate_team).to_not be_valid
  end

  it "can add multipe users to a team" do
    subject.save!
    subject.users << User.create(name: Faker::Name.name, email: Faker::Internet.email)
    subject.users << User.create(name: Faker::Name.name, email: Faker::Internet.email)
    expect(subject.reload.users.count).to eq(2)
  end

end
