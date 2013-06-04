class PostsController < ApplicationController
	def index
		@posts = Post.all
		render text: @posts.map { |p| "#{p.title}: #{p.annot}" }.join("<br>")		
	end

	# /posts/:id GET
	def show
		
	end

	# /posts/new GET
	def new
		
	end

	# /posts/:id/edit GET
	def edit
		
	end

	# /posts  POST
	def create
		p params
		@post = Post.create(params[:post])
		render text: "post id: #{@post.id} title: #{@post.title} (#{!@post.new_record?})"
	end

	# /posts/:id PUT
	def update
		
	end

	# /posts/:id DELETE
	def destroy
		
	end
end
