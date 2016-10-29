class User < ApplicationRecord
  has_and_belongs_to_many :teams, dependent: :destroy
  has_many :alerts, dependent: :destroy
end
