class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def record_invalid(invalid)
    render json: { status: 'error', message: invalid.record.errors.full_messages.join(",")}
  end

  def record_not_found
    render json: { status: 'error', message: "没有找到对应的数据"}
  end

  def render_data(status: status = "success", msg: msg = "请求成功", data: )
    render json: { status: status, msg: msg, data: data }
  end
end
