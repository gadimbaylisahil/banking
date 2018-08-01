class AddCommissionToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :commission, :integer, null: false, default: 0
  end
end
