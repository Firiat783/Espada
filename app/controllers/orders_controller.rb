class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find params[:id]
    unless @order.user_id == current_user.id
      raise 'Order not found', code: 404
    end
  end

  def create
    # Проверка на товары
    unless current_user.item_users.any?
      redirect_to root_path    # 1.a
    end
    # Создание заказа
    # Здесь вызван метод create!, который в случае неудачи вызовет вывод исключения на страницу.
    order = Order.create! user_id: current_user.id,
                          price: ItemUser.total_price(current_user),
                          status: 'created'
    # Копирование содержимого корзины в заказ
    current_user.item_users.each do |i|
      ItemOrder.create! quantity: i.quantity,
                        order_id: order.id,
                        item_id: i.item_id,
                        # Здесь можно было написать i.item.id, но тогда это был бы один лишний запрос в БД, что нехорошо. А так мы просто обращаемся к свойству объекта
                        price: i.item.price
    end
    # Очистка корзины
    current_user.item_users.destroy_all
    # Переход на просмотр заказа
    redirect_to order
  end

end
