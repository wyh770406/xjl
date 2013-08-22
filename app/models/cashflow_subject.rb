class CashflowSubject < ActiveRecord::Base
  attr_accessible :name, :code, :company_id
  belongs_to :company
  has_many :cashflow_subjects

  validates :name, presence: true, uniqueness: { scope: :company_id }
  validates :code, presence: true, uniqueness: { scope: :company_id }

end
