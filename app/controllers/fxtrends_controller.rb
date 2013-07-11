# encoding: utf-8

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
		require "date"
		@fxtrend = params[:fxtrend]
		pamm = @fxtrend[:pamm]
		puts YAML::dump(@fxtrend[:pamm])

		agent = Mechanize.new
		page = agent.get('http://fx-trend.com/pamm/'+@fxtrend[:pamm]+'/')
		pamm_info = ''
		firstArray = []
		tmpArray = []
		flagB = false 
		page.search("table.my_accounts_table tr td").each do |td|

			if td.text.empty?
				next
			end

			# Проверям флаг flagB. Если он включен - ищем подстроки процентов
			if flagB
				# ~ Определяем строки вида "-26.75%" | "26.75%"
				md = /^([0-9.-]+)%$/.match td.text.to_s 
				if md.nil?
					next
				end	
				# Нашли значение процента. Сохраним в массив
				tmpArray << md[1].to_f
				firstArray << tmpArray
				tmpArray =[]
				flagB = false
			else
			
			end

			# ~ Определяем строки вида "Декабрь 2011" ~

			md = /^([А-Яа-я]+)\s([0-9]{4,})$/.match td.text.to_s 
			if md.nil?
				next
			end
			unless md[1].empty? && md[2].empty?
				# есть совпадение. Установим флаг, преобразуем месяц и год в метку времени
				flagB = true
				month = md[1].to_s
				year = md[2].to_i
				case month
				when 'Январь'
				  month = 1
				when 'Февраль'
				  month = 2
				when 'Март'
				  month = 3
				when 'Апрель'
				  month = 4
				when 'Май'
				  month = 5
				when 'Июнь'
				  month = 6
				when 'Июль'
				  month = 7
				when 'Август'
				  month = 8
				when 'Сентябрь'
				  month = 9
				when 'Октябрь'
				  month = 10
				when 'Ноябрь'
				  month = 11
				when 'Декабрь'
				  month = 12
				else
				  month = nil
				end
				
				date = Date.new(year,month)
				tmpArray << date			
			end
		end

		firstArray.each do |el|
			@fxtrend = Fxtrend.new(pamm: pamm, date: el[0], percent: el[1], kind: 'month')
			@fxtrend.save!	
		end

		return render :text => YAML::dump(firstArray)
		redirect_to fxtrends_path(id: pamm)

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

	def show
		#puts YAML::dump(params[:pamm])
		@fxtrends = Fxtrend.where("kind = 'month' AND pamm=?", params[:id])
		deposit = 100
		@arData = []
		@fxtrends.each do |el| 
			if el.percent.to_f > 0 
				el.percent = el.percent.to_f/2 			
			end
			deposit = deposit.to_f*(el.percent.to_f/100 + 1)
			deposit = deposit.round 2
			@arData << {date: el.date, deposit: deposit}		
		end
	end

end