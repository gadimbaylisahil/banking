class AddPendingAmountToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :pending_amount, :integer, null: false, default: 0
  end
end
