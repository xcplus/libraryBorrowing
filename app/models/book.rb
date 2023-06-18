class Book < ApplicationRecord

  has_many :transactions

  validates :title, presence: true, uniqueness: true
  validates_numericality_of :inventory, greater_than_or_equal_to: 0
  validates_numericality_of :total_items, greater_than_or_equal_to: 0

  before_validation do 
    if self.inventory > self.total_items
      errors.add :base, "inventory can't great than total items"
    end
  end


  def actual_income(start_time:, end_time:)
    start_time = Time.parse(start_time) rescue (Time.now - 1.week)
    end_time = Time.parse(end_time) rescue Time.now
    self.transactions.borrowing.where(trans_time: start_time..end_time).sum(:price)
  end
end
