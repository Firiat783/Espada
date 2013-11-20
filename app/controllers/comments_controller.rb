class CommentsController < ApplicationController

  # GET /comments/new
  def new
    @comment = Comment.new
  end


  def create
    @comment = Comment.new(comment_params)

    if @comment.save

        #хранилище оцкенок
      all_scores =[]

        #находим все оценки
      @comment.item.comments.each do |comment|
        if comment.rating
          all_scores << comment.rating
        end
      end

        #если оценки есть - считаем среднеарфиметическое и считаем
      if all_scores.any?

        #считаем среднеарифметическое

        avg = all_scores.sum.to_f / all_scores.length

        #сохраняем их к товару

        @comment.item.update_attribute :rating, avg
      end

        redirect_to @comment.item, notice: 'Comment was successfully created.'
    else
        redirect_to @comment.item, alert: 'Comment is not created'
    end


  end

  private

  def comment_params
      params[:comment].permit(:name, :item_id, :message, :rating)
  end

end
