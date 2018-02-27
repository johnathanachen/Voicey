require 'rails_helper'

RSpec.describe Memo, type: :model do
    # creates a user as the subject
    subject {
      User.new(name: "johnatan", email: "johnathan@test.com")
    }

    # checks validations
    describe "Validations" do
      it "is valid with valid attributes" do
        # creates a new memo with valid attributes
        memo = Memo.new(
          title: "My Memo",
          date: DateTime.now.utc,
          text_body: "This is the text body",
          user: subject
        )
        expect(memo).to be_valid
      end

      # if title is not valid, return error message
      it "is invalid without a title" do
        bad_memo = Memo.new(
          title: nil,
          date: DateTime.now.utc,
          text_body: "This is the text body",
          user: subject
        )
        expect(bad_memo).to_not be_valid
      end

       # if date is not valid, return error message
      it "is invalid without an time" do
        bad_memo = Memo.new(
          title: "My Memo",
          date: nil,
          text_body: "This is the text body",
          user: subject
        )
        expect(bad_memo).to_not be_valid
      end

       # if text body is not valid, return error message
      it "is invalid without an text body" do
        bad_memo = Memo.new(
          title: "My Memo",
          date: DateTime.now.utc,
          text_body: nil,
          user: subject
        )
        expect(bad_memo).to_not be_valid
      end

       # if user is not valid, return error message
      it "is invalid without a user" do
        bad_memo = Memo.new(
          title: "My Memo",
          date: DateTime.now.utc,
          text_body: nil,
          user: nil
        )
        expect(bad_memo).to_not be_valid
      end
    end

    # test for model associations
    describe "Associations" do
      # checks one to many
      it "should have many memos" do
        assoc = Memo.reflect_on_association(:user)
        expect(assoc.macro).to eq :belongs_to
      end
end
