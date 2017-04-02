class AlertSerializer < ActiveModel::Serializer
  type :alerts
  
  attributes :id, :alert_text, :alert_location

  belongs_to :team
end
