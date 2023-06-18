class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :trans_type, comment: "交易类型"
      t.decimal :price, comment: "交易金额"
      t.datetime :trans_time, default: "now()", comment: "交易时间"
      t.integer :assoc_id, comment: "关联的返回id"

      t.timestamps
    end

    add_index :transactions, [:user_id, :book_id, :trans_type]
  end
end
