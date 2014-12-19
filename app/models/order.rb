class Order < ActiveRecord::Base
	# geocoded_by :address
	# after_validation :geocode, :if => :address_changed?       

	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
	belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
	belongs_to :state, :class_name => "State", :foreign_key => "state_id"
	mount_uploader :image, ImageUploader

	validates_presence_of :name, :description, :price, :on => :create, :message => "can't be blank"
end

