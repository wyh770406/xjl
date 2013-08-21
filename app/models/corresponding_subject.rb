class CorrespondingSubject < ActiveRecord::Base
  attr_accessible :name, :code

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

end
