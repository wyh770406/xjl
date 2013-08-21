class AddCodeToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :code, :string

  	add_index :companies, :code
  end
end
