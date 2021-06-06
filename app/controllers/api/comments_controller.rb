class Api::CommentsController < Api::BaseController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_post, only: [:index, :create]
  before_action :check_author, only: [:update, :destroy]

  # GET /posts/:post_id/comments
  def index
    @comments = @post.comments

    render json: @comments
  end

  # GET /posts/:post_id/comments/1
  def show
    render_resource(@comment)
  end

  # POST /posts/:post_id/comments
  def create
    @comment = Comment.create(comment_params)

    render_resource(@comment)
  end

  # PATCH/PUT /comments/1
  def update
    @comment.update(comment_params)

    render_resource(@comment)
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def check_author
      if @comment.user.id != current_user.id
        render json: { error: 'You aren\'t authorized to perform this action, the comment doesn\'t belongs to you !' }
      end
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content).merge(params.permit(:post_id)).merge({ author_id: current_user.id })
    end
end
