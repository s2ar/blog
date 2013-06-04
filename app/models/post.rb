class Post < ActiveRecord::Base
	attr_accessible :title, :annot, :description, :enable
	validates :title, :annot, :description, :presence => true 

	after_create {puts "created"}
	after_destroy {puts "destroyed"}
end