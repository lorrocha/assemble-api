class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :teams, dependent: :destroy
  has_many :alerts, through: :teams

  before_save :ensure_authentication_token

  def self.on_teams(teams)
    joins(:teams).where(:teams => {:id => teams})
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def teammates
    self.class.on_teams(teams)
  end

  def has_alert?(alert)
    alerts.where(id: alert.id).present?
  end

  def has_team?(team)
    teams.where(id: team.id).present?
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
