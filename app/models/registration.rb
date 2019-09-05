class Registration < ApplicationRecord
  belongs_to :plan
  belongs_to :unity

  validates_presence_of :name, :email
end
