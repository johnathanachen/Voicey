require 'rails_helper'

RSpec.describe User, type: :model do
    before {
        User.new(name: "Eliel", email: "eliel@test.com")
    }

    describe "Validations" do
    it "is valid with valid attributes" do
      user = User.new(name: "johnathan", email: "johnathan@test.com")
      expect(user).to be_valid
    end

    describe "Associations" do
        it "should have many memos" do
            assoc = User.reflect_on_association(:memos)
            expect(assoc.macro).to eq :has_many
        end
    end

    it "is invalid without a name" do
      bad_user = User.new(name: nil, email: "test@mail.com")
      expect(bad_user).to_not be_valid
    end

    it "is invalid without an email" do
      bad_user = User.new(name: "johnathan", email: nil)
      expect(bad_user).to_not be_valid
    end
  end
end
