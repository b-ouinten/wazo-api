class Api::PostsController < Api::BaseController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :check_author, only: [:update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render_resource(@post)
  end

  # POST /posts
  def create
    @post = Post.create(post_params)
    
    render_resource(@post)
  end

  # PATCH/PUT /posts/1
  def update
    @post.update(post_params)
    
    render_resource(@post)
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Check if current user is the author
  def check_author
    if @post.user.id != current_user.id
      render json: { error: 'You aren\'t authorized to perform this action, the post doesn\'t belongs to you !'}
    end
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:content).merge({ author_id: current_user.id })
  end
end
