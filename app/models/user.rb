class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :teams, dependent: :destroy

  before_save :ensure_authentication_token

  def self.on_teams(teams)
    joins(:teams).where(:teams => {:id => teams})
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def teammates(team_id = nil)
    ts = teams
    ts = ts.where(:id => team_id) if team_id
    self.class.on_teams(ts)
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
