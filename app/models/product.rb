class Product < ActiveRecord::Base

  validates :name, :price, :description, :presence => true
  validates :price, :numericality => :true

end

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  price       :integer
#  created_at  :datetime
#  updated_at  :datetime
#
