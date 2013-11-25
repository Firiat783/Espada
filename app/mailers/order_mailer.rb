class OrderMailer < ActionMailer::Base

  default from: "noreply@immense-island-9427.herokuapp.com"


  def order_created_for_user(order)
    @order = order
    mail(to: order.user.email, subject: 'Оформлен заказ').deliver
  end

  def order_created_for_admin(order)
    @order = order
    mail(to: 'luckydance80@gmail.com', subject: 'Оформлен новый заказ').deliver
  end

end
