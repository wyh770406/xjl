class CreateCorrespondingSubjects < ActiveRecord::Migration
  def change
    create_table :corresponding_subjects, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :corresponding_subjects, :code
  end
end
