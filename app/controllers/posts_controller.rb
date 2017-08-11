class PostsController < ApplicationController
  before_action :authenticate_user!
                # only: [:new, :edit]
                # allow only logged in user to see certain pages
                # except: [:new, :edit] opposite effect
  def index
    news_url = 'https://newsapi.org/v1/articles?source=breitbart-news&sortBy=top&apiKey=6ac7d64def064fb9a03de00329cd1ae0'
    response = HTTParty.get(news_url)

    @news_data = response

    places_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=1.290270,103.851959&radius=500&types=food&name=steak&key=AIzaSyB-bkXlPjm1Px9j2uLFw4d1sEKagKAK6r4'

    places_response = HTTParty.get(places_url)

    @places_data = places_response


    # render json: current_user.posts
    @all_posts = current_user.posts
    # @new_post = Post.new will not be tagged to any user
    @new_post = current_user.posts.new

  end

  def show
    # render json: params
    @post = Post.find(params[:id])
  end

  def new
    render html: 'show form to create new post'
  end

  def edit
    render html: 'show form to edit existing post'
  end

  def create
    # mass assignment way
    creating_post = params.require(:post).permit(:title, :content, :user_id)

    # long way to create
    # creating_post = current_user.post.build
    # creating_post.title = params[:post][:title]
    # render json: @creating_post

    Post.create(creating_post)

    redirect_to posts_path
  end

  def destroy
    # Post.destroy(params[:id]) shortcut way
    deleted_post = Post.find(params[:id])
    deleted_post.destroy

    redirect_to posts_path
  end

  def edit
    @current_post = Post.find(params[:id])
  end

  def update
    # render json: post_update_params
    # render json: params
    updated_post = Post.find(params[:id])
    updated_post.update(post_update_params)
    # updated_post.update(params[:post]) => mass assignment

    redirect_to posts_path

  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def post_update_params
    params.require(:post).permit(:title, :content)
  end

end
