class CashFlow < ActiveRecord::Base
  attr_accessible :corresponding_subject_id, :cashflow_subject_id, :company_id, :cashflow_date, :cashflow_amount, :description
  belongs_to :company
  belongs_to :corresponding_subject
  belongs_to :cashflow_subject

  validates :corresponding_subject_id, :cashflow_subject_id, :company_id, :cashflow_date, :cashflow_amount, presence: true
  validates :cashflow_amount, numericality: { greater_than: 0 }
end