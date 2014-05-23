class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :payments

  def cat_current_address
 	[full_name,address_line1,address_line2,city,state,zip,country].join(" ")
  end
end
