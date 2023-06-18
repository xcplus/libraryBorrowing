class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password

  has_many :transactions

  before_validation do
    self.username = username.to_s.downcase.strip
  end

  validates :username, presence: true, uniqueness: true, length: 3..20
  validates :password, presence: true, length: 6..30, on: :create

  validates_numericality_of :balance, greater_than_or_equal_to: 0


  def borrowing(book)
    transaction = nil
    book.with_lock do
      # 当用户借书时，创建一个借书交易，用户的余额减少，交易金额为借书费用
      decre_inventory = book.inventory - 1
      incre_borrowing_times = book.borrowing_times + 1
      user_balance = self.balance - book.borrow_price
      book.update!(inventory: decre_inventory, borrowing_times: incre_borrowing_times)
      self.update!(balance: user_balance)
      transaction = Transaction.create!(user_id: self.id, book_id: book.id, price: book.borrow_price, trans_type: "borrowing", trans_time: Time.now)
    end
    transaction
  end

  def send_back(book)
    transaction = nil
    book.with_lock do
      # 当用户还书时，创建一个还书交易，用户的余额不变，交易金额为0。
      incre_inventory = book.inventory + 1
      book.update!(inventory: incre_inventory)
      # 找到该用户的借阅记录，关联一条
      borrowing = self.transactions.borrowing.where(book_id: book.id, assoc_id: nil).first
      transaction = self.transactions.create!(book_id: book.id, price: 0, trans_type: "send_back", trans_time: Time.now)
      borrowing.update!(assoc_id: transaction.id)
    end
    transaction
  end

  def month_borrowings
    self.transactions.borrowing.select("strftime('%Y-%m', trans_time) AS month, SUM(price) AS cost, COUNT(book_id) as book_counts").group("month")
  end

  def year_borrowings
    self.transactions.borrowing.select("strftime('%Y', trans_time) AS year, SUM(price) AS cost, COUNT(book_id) as book_counts").group("year")
  end
end
