require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(username: "testuser", password: "password", password_confirmation: "password") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a username" do
      subject.username = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:username]).to include("can't be blank")
    end

    it "is not valid with a duplicate username" do
      described_class.create(username: "testuser", password: "password", password_confirmation: "password")
      expect(subject).to_not be_valid
      expect(subject.errors[:username]).to include("has already been taken")
    end
  end

  describe "password encryption" do
    it "encrypts the password" do
      expect(subject.password_digest).to_not be_nil
    end

    it "authenticates with the correct password" do
      subject.save
      expect(subject.authenticate("password")).to be_truthy
    end

    it "does not authenticate with an incorrect password" do
      subject.save
      expect(subject.authenticate("wrongpassword")).to be_falsey
    end
  end
end
