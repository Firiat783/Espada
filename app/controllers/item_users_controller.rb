class ItemUsersController < ApplicationController
  before_action :authenticate_user!
  # GET /item_users
  def index
    @item_users = current_user.item_users
  end


  def create
    item = Item.find params[:item_user][:item_id]
      item_user = ItemUser.where(user_id: current_user.id).where(item_id: item.id).first
    if item_user
       item_user.quantity = item_user.quantity + 1
       item_user.save
    else

        item_user = ItemUser.new
          item_user.item_id = item.id
            item_user.user_id = current_user.id
              item_user.quantity = 1
                item_user.save
    end
    redirect_to :back
    end


  def update
    #найти объект записи
    item_user = ItemUser.find(params[:id])
    if item_user.user_id = current_user.id
    #проверить валидацию#изменить значение
      item_user.update quantity: params[:item_user][:quantity]
    end
    #Вернуть в корзину
    redirect_to :back
  end


  def destroy
    item_user = ItemUser.find(params[:id])
      if item_user.user_id = current_user.id
         item_user.destroy
      end
    redirect_to item_users_url
  end

  end