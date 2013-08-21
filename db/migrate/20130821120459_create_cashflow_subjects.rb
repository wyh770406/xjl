class CreateCashflowSubjects < ActiveRecord::Migration
  def change
    create_table :cashflow_subjects, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.references :company
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :cashflow_subjects, :company_id
    add_index :cashflow_subjects, :code
  end
end
