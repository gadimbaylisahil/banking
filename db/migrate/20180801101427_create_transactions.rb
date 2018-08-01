class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
	    t.string :status, null: false, default: 'processing'
      t.integer :amount, null: false
	    t.references :transfer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
