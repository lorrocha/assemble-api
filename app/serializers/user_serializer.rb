class UserSerializer < ActiveModel::Serializer
  type :users

  attributes :id, :email, :username, :profile_text

  has_many :teams
  belongs_to :teams
end
