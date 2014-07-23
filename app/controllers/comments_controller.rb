class CommentsController < ApplicationController

  def create
    comment_params = user_params
    # add the user id if we've got one
    comment_params.merge!(user_id: current_user.id) if user_signed_in?
    logger.debug comment_params.inspect

    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: 'Comment was created successfully.'}
        format.json { render json: @comment, status: :created}
      else
        format.html { redirect_to root_path, notice: "Comment was not created: #{@comment.errors.inspect}" }
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
    params.permit(:event_id, comment: [:content]).tap do |list|
      list[:content] = list[:comment][:content]
      list.delete(:comment)
    end
  end
end