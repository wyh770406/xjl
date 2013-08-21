class Company < ActiveRecord::Base
  attr_accessible :address, :name, :phone
  has_many :cashflow_subjects

  validates :name, presence: true, uniqueness: true

end
