class CommentsController < ApplicationController

  def create
    comment_params = user_params
    # add the user id if we've got one
    comment_params.merge!(user_id: current_user.id) if user_signed_in?

    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: 'Comment was created successfully.'}
        format.json { render json: @comment, status: :created}
      else
        format.html { redirect_to root_path, notice: 'Comment was not created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:comment).permit(:content, :event_id)
  end
end