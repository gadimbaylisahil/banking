class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :transfer_amount
      t.string :status, null: false, default: 'pending'
      t.references :account, index: true, foreign_key: true
      t.timestamps
    end
  end
end
