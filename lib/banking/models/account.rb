class Account < ActiveRecord::Base
	belongs_to :bank
	has_many :transfers
	has_many :transactions, through: :transfers
	validates :name, presence: true
	validates :balance, presence: { default: 0 }
end