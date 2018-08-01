class ChangeReferences < ActiveRecord::Migration[5.2]
  def change
    remove_reference :accounts, :bank
    remove_reference :transfers, :account
    remove_reference :transactions, :transfer
    add_reference :accounts, :bank, index: true, foreign_key: true, null: false
    add_reference :transfers, :account, index: true, foreign_key: true, null: false
    add_reference :transactions, :transfer, index: true, foreign_key: true, null: false
  end
end
