### 功能逻辑
1. 先根据需求整理出需要的表和字段
users books transactions 三个表

2. 根据api需求，写相关的路由以及代码
```ruby
# 1. 创建用户接口
# post http://localhost:3000/users 
# params: { "username": "abcd", "password": "12345678", "balance": 120 }
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "user_id": 1
#     }
# }

# 2. 创建借阅交易
# post http://localhost:3000/transactions/borrowing
# params: { "user_id": 1, "book_id": 1 }
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "transaction": {
#             "id": 7,
#             "user_id": 1,
#             "book_id": 1,
#             "trans_type": "borrowing",
#             "price": "3.0",
#             "trans_time": "2023-06-18T04:57:49.439Z",
#             "assoc_id": null,
#             "created_at": "2023-06-18T04:57:49.444Z",
#             "updated_at": "2023-06-18T04:57:49.444Z"
#         }
#     }
# }

# 3. 创建返回交易
# post http://localhost:3000/transactions/send_back
# params: { "user_id": 1, "book_id": 1 }
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "transaction": {
#             "id": 8,
#             "user_id": 1,
#             "book_id": 1,
#             "trans_type": "send_back",
#             "price": "0.0",
#             "trans_time": "2023-06-18T04:58:25.123Z",
#             "assoc_id": null,
#             "created_at": "2023-06-18T04:58:25.124Z",
#             "updated_at": "2023-06-18T04:58:25.124Z"
#         }
#     }
# }

# 4. 查询用户的账户状态，参数为用户ID，返回当前余额，借书
# get http://localhost:3000/users/1
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "current_balance": "111.0",
#         "borrow_books": [
#             {
#                 "title": "如何阅读一本书",
#                 "id": 5
#             }
#         ]
#     }
# }

# 5. 某本书的实际收入
# get http://localhost:3000/books/1/income?start_time=2023-05-12&end_time=2023-06-18
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "actual_income": "9.0"
#     }
# }

# 6. 月度和年度报告
# get http://localhost:3000/users/1/reports
# 返回数据:
# {
#     "status": "success",
#     "msg": "请求成功",
#     "data": {
#         "month_reports": [
#             {
#                 "month_date": "2023-06-01T00:00:00.000Z",
#                 "book_counts": 3,
#                 "cost": "9.0"
#             }
#         ],
#         "year_reports": [
#             {
#                 "year_date": "2023-01-01T00:00:00.000Z",
#                 "book_counts": 3,
#                 "cost": "9.0"
#             }
#         ]
#     }
# }
```