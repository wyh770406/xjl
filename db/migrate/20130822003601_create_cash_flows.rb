class CreateCashFlows < ActiveRecord::Migration
  def change
    create_table :cash_flows, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :company
      t.references :cashflow_subject
      t.references :corresponding_subject
      t.date :cashflow_date
      t.decimal :cashflow_amount, :precision => 8, :scale => 2
      t.text :description

      t.timestamps
    end
    add_index :cash_flows, :company_id
    add_index :cash_flows, :cashflow_date
  end
end
