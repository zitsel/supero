class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :ordered_items, :through => :orders
  has_many :payments
  has_many :shipments, :through => :orders
  has_many :addresses, as: :addressable


end
