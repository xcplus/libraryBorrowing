class BooksController < ApplicationController
  # 某本书的实际收入 参数为该书的ID和时间范围，返回该书在这段时间内获得的交易金额
  def income
    book = Book.find(params[:id])
    actual_income = book.actual_income(start_time: params[:start_time], end_time: params[:end_time])
    render_data(data: { actual_income: actual_income })
  end
end
