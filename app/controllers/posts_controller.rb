class PostsController < ApplicationController

	before_filter :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all				
	end

	# /posts/:id GET
	def show
		if @post
			render 'posts/show'
		else
			render text: 'Page not found', status: 404
		end
	end
	#def upvote
		
	#end

	# /posts/new GET
	def new
		@post = Post.new
	end

	# /posts/:id/edit GET
	def edit		
	end

	# /posts  POST
	def create
		@post = Post.new(params[:post])
		puts YAML::dump("asdasdas")
		@post.save!
		#@post = Post.create(params[:post])

		if @post.errors.empty?
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	# /posts/:id PUT
	def update	
		@post.update_attributes(params[:post])		 
		if @post.errors.empty?
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	# /posts/:id DELETE
	def destroy		
		@post.destroy
		redirect_to action: 'index'
	end

	private
		def find_post
			@post = Post.where(id: params[:id]).first
			render_404 unless @post
		end
end
