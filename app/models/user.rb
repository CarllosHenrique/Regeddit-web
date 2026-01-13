class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A\+?[0-9\-\s]+\z/ }
  validates :bio, length: { maximum: 500 }, allow_blank: true

  before_validation :set_username, on: :create

  private

  def set_username
    return if name.blank?
    return unless username.blank?

    base = name.strip.parameterize(separator: ".")
    base = "user" if base.blank?

    candidate = base
    suffix = 2

    while self.class.exists?(username: candidate)
      suffix_str = ".#{suffix}"
      max_base_len = 30 - suffix_str.length
      candidate = "#{base[0, max_base_len]}#{suffix_str}"
      suffix += 1
    end

    self.username = candidate
  end
end
