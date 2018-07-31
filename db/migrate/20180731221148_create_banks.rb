class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name, null: false
	    t.timestamps
    end
  end
end
