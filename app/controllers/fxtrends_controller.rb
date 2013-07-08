class FxtrendsController < ApplicationController

	def index
		@fxtrends = Fxtrend.all
	end

	def new
		@fxtrend = Fxtrend.new
	end

	def create

		#require 'rubygems'
		require 'mechanize'
		@fxtrend = params[:fxtrend]

		puts YAML::dump(@fxtrend[:pamm])

		agent = Mechanize.new
		page = agent.get('http://fx-trend.com/pamm/'+@fxtrend[:pamm]+'/')

		page.search("table.my_accounts_table tr td").each do |td|
			
			#puts td.text
		
			pamm_info += YAML::dump(td.text)
		end

		return render :text => YAML::dump(pamm_info)
		redirect_to fxtrends_path(@fxtrend)

		#@post = Post.new(params[:post])
		#puts YAML::dump("asdasdas")
		#@post.save!
		#@post = Post.create(params[:post])

		#if @post.errors.empty?
			#redirect_to post_path(@post)
		#else
			#render 'new'
		#end
	end

end