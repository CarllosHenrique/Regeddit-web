class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A\+?[0-9\-\s]+\z/ }, allow_blank: true
  validates :bio, length: { maximum: 500 }, allow_blank: true

  before_validation :set_username, on: :create

  private

  def set_username
    return if username.present?

    loop do
      self.username = Faker::Internet
        .unique
        .username(separators: %w[. _ -])
        .downcase
        .truncate(30, omission: "", length: 30)

      return username unless User.exists?(username: username)
    end
  end
end
