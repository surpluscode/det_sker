class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action only: [:edit, :update] do
    user_can_edit? set_comment
  end


  def create
    comment_params = user_params
    # add the user id if we've got one
    comment_params.merge!(user_id: current_user.id) if user_signed_in?

    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to event_path(comment_params[:event_id]), notice: 'Comment was created successfully.'}
        format.json { render json: @comment, status: :created}
      else
        format.html { redirect_to root_path, notice: "Comment was not created: #{@comment.errors.inspect}" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # since this action is called via ajax,
  # we don't want to show the standard layout
  def edit
    render layout: nil
  end


  def update
    respond_to do |format|
      if @comment.update(user_params.except(:comment_id))
        format.html { redirect_to event_path(@comment.event_id), notice: 'Comment updated successfully'}
        format.json { render json: @comment }
      else
        format.html { redirect_to event_path(user_params[:event_id]), notice: 'Comment could not be updated'}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Little bit hacky - since we need params from both the nested
  # comments hash and the upper level we need to go through an
  # extra layer of processing, e.g. given this:
  # {"comment"=>{"content"=>"first comment!"}, "event_id"=>"989132030"}
  # we want this:
  # {"event_id"=>"989132030", "content"=>"first comment!"}
  def user_params
    params.permit(:id, :event_id, comment: [:content, :event_id, :comment_id]).tap do |list|
      list.merge!(list.delete(:comment)) if list[:comment]
    end
  end

    def set_comment
      @comment = Comment.find(user_params[:id])
    end
end