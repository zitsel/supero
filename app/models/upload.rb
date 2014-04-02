class Upload < ActiveRecord::Base
  has_attached_file :uploaded_file,
   styles: {
    original: "4000x4000>",
    large: "1500x1500>",
    medium: "300x300>",
    small: "200x200>",
    thumb: "100x100>"
    },
    default_url: "/images/:style/missing.png",
    :processors => [:cropper]
  

  belongs_to :product
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  #after_update :reprocess_image, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def uploaded_file_geometry(style = :original)
  	@geometry ||= {}
  	@geometry[style] ||= Paperclip::Geometry.from_file(uploaded_file.path(style))
  end

  def path
    ["public",uploaded_file.url.gsub(/\?.*/,"")].join("")
  end

  private
  def reprocess_image
    uploaded_file.assign(uploaded_file)
    uploaded_file.save
    #uploaded_file.reprocess!
  end

  #validates :product_id, presence: true
end
