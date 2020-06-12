class Api::V1::CommentsController < ApplicationController
  protect_from_forgery :except => [:create]
  def show
    @comments = Comment.where(post_id: params[:id])
    render 'show', formats: :json, handlers: 'jbuilder'
  end
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.fetch(:postdata, {}).permit(:current_time, :content, :user_id, :post_id)
  end
end
