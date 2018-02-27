class User < ApplicationRecord
    has_many :memos
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    # has password before saving a User
    before_save :encrypt_password
    # generate a token for authentication before creating a User
    before create :generate_token
    # adds a virtual password field, which we will use when creating a user
    attribute :password, :string

    # authenticate user by email
    def self.authenticate(email, password)
        # find the user associated with the email
        user = self.find_by_email(email)
        # check if the password entered matches user's password
        if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end

    # if password is present, check salt and hash
    def encrypt_password do
        if password.present?
            self.password_salt = BCrypt::Engine.generate_salt
            self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
        end
    end

    # generates a token for a user
    def generate_token
        token_gen = SecureRandom.hex
        self.token = token_gen
        toekn_gen
    end

end
