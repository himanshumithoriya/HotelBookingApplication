class Owner < User
  validates :name, presence: true
	validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
	validates :password, presence: true
end