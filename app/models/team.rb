class Team < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :alerts, dependent: :destroy
end
