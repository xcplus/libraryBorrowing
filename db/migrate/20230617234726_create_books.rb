class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :inventory, default: 0, comment: "库存"
      t.integer :total_items, default: 0, comment: "总共有多少"
      t.integer :borrowing_times, default: 0, comment: "借阅次数"
      t.decimal :borrow_price, default: 0, comment: "借阅费用"

      t.timestamps
    end
  end
end
