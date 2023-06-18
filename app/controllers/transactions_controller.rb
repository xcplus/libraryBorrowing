class TransactionsController < ApplicationController
  before_action :get_user_and_book
  # 创建借书交易
  def borrowing
    transaction = @user.borrowing(@book)
    Rails.logger.info transaction.inspect
    render_data(data: { transaction: transaction })
  end

  # 创建还书交易
  def send_back
    transaction = @user.send_back(@book)
    render_data(data: { transaction: transaction })
  end

  private

  def get_user_and_book
    @user = User.find(params[:user_id])
    @book = Book.find(params[:book_id])
  end
end
