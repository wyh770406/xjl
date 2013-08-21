class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
