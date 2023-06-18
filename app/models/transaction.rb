class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :trans_type, [:borrowing, :send_back]
end
