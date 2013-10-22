class Diagnostic < ActiveRecord::Base
  attr_accessible :description, :name
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :description, presence: true, length: { minimum: 2}
  
  has_many :segments, dependent: :destroy
  
  def make_chart_for_user(user_id)
    puts "HERE I AM!!!"
    g = Gruff::Spider.new(100,1200)
    g.hide_axes = false
    g.hide_text = false
    g.transparent_background = false
    #g.theme = Gruff::Themes::THIRTYSEVEN_SIGNALS
    g.legend_font_size = 10
    g.bottom_margin = 40
    n = 1
    if self.segments.count > 3
      g.rotation = 180/self.segments.count 
      self.segments.each do |segment|
        g.data segment.name, 100-n*10
        n += 1
      end
    end

    g.write("public/results/#{self.id}-#{user_id}.png")
  end
  
end
