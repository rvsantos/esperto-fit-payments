class Registration < ApplicationRecord
  belongs_to :plan
  belongs_to :unity
  has_many :payments


  validates_presence_of :name, :email, :cpf
  validates_uniqueness_of :cpf
end
