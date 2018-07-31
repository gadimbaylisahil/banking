class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :balance, null: false, default: 0
      t.references :bank, index: true, foreign_key: true
      t.timestamps
    end
  end
end
