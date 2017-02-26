class TeamSerializer < ActiveModel::Serializer
  type :teams

  attributes :id, :team_name, :privacy

  has_many :users
  has_many :alerts
end
