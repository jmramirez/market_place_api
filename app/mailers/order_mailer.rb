class OrderMailer < ApplicationMailer
  default from: "no-reply@marketplace.com"

  def send_confirmation(order)
    @order = order
    @user = @order.user
    mail to: @user.email, subject: "Order Confirmation"
  end

  def create
    order = current_user.orders.build(order_params)

    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: 201, location: [:api,current_user,order]
    else
      render json: { errors: order.errors }, status: 422
    end
  end

end
