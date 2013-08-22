class CorrespondingSubject < ActiveRecord::Base
  attr_accessible :name, :code

  has_many :cash_flows

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

end
