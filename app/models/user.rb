class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 50 },
            format: { with: /\A[^<>&;]+\z/, message: I18n.t("errors.messages.invalid") }

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            length: { maximum: 100 }

  validates :phone,
            format: {
              with:    /\A\+?\d{1,4}[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}\z/,
              message: I18n.t("errors.messages.invalid_phone")
            },
            allow_blank: true,
            length: { maximum: 20 }

  validates :bio,
            length: { maximum: 320 },
            allow_blank: true

  before_validation :set_username, on: :create


  has_one_attached :avatar

  private

  def set_username
    return if username.present?

    attempts = [
      -> { name.to_s.parameterize.tr("_", ".") },
      -> { Faker::Internet.unique.username(separators: %w[. _]).downcase },
      -> { "#{Faker::Name.initials}#{rand(10..99)}" },
      -> { Faker::Internet.unique.slug(words: nil, glue: ".") }
    ]

    attempts.each do |generator|
      8.times do
        candidate = generator.call.truncate(24, omission: "")
        next if candidate.length < 3
        next if User.exists?(username: candidate)

        self.username = candidate
        return
      end
    end

    self.username = "u#{SecureRandom.hex(6)}"
  end
end
