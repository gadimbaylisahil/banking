class Transaction < ActiveRecord::Base
	belongs_to :transfer
	validates :amount, numericality: { greater_than: 0 }
end