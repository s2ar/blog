class PostsController < ApplicationController
	def index
		@posts = Post.all
				
	end

	# /posts/:id GET
	def show
		if @post = Post.where(id: params[:id]).first
			render 'posts/show'
		else
			render text: 'Page not found', status: 404
		end
	end

	# /posts/new GET
	def new
		
	end

	# /posts/:id/edit GET
	def edit
		
	end

	# /posts  POST
	def create
		@post = Post.create(params[:post])
		if @post.errors.empty?
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	# /posts/:id PUT
	def update
		
	end

	# /posts/:id DELETE
	def destroy
		
	end
end
