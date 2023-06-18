class UsersController < ApplicationController
  before_action :set_user, except: [:create]
  # 创建用户
  def create
    user = User.create!(user_params)
    render_data(data: { user_id: user.id })
  end

  # 查询用户状态
  def show
    borrow_books = Transaction.borrowing.includes(:book).where(user_id: @user.id, assoc_id: nil).select("books.title, book_id").references(:books)
    data = {
      current_balance: @user.balance,
      borrow_books: borrow_books.map{|book| {title: book.title, id: book.id}}
    }
    render_data(data: data)
  end

  # 创建月度和年度报告，包括借书数量和花费金额。
  def reports
    month_borrowings = @user.month_borrowings
    year_borrowings = @user.year_borrowings
    render_data(data: {
      month_reports: month_borrowings.map{|mb| { month_date: mb.month, book_counts: mb.book_counts, cost: mb.cost }},
      year_reports: year_borrowings.map{|yb| { year_date: yb.year, book_counts: yb.book_counts, cost: yb.cost }},
    })
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :password, :balance)
  end
end
