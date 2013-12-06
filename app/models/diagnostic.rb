class Diagnostic < ActiveRecord::Base
  attr_accessible :description, :name
  
  validates :name, presence: true, length: { minimum: 2}
  
  validates :description, presence: true, length: { minimum: 2}
  
  has_many :segments, dependent: :destroy
  
  def make_chart_for_user(user_id)
    g = Gruff::Spider.new(100,1200)
    g.hide_axes = false
    g.hide_text = false
    g.transparent_background = false
    g.legend_font_size = 10
    g.bottom_margin = 40
    g.font = ("app/assets/fonts/HelveticaNeue.ttf")
    g.theme = {
      :colors => %w(grey),
      :marker_color => 'black',
      :background_colors => %w(#f5f5f5 #f5f5f5)
    }
    if self.segments.count > 3
      g.rotation = 180/self.segments.count 
      self.segments.each do |segment|
        g.data segment.name, segment.score_for_user(user_id)
      end
    end

    g.write("public/results/#{self.id}-#{user_id}.png")
  end
  
  def complete_for_user(user)
    completed = 0
    total = 0
    self.segments.each do |seg|
      completed += seg.complete_for_user(user)
      total += 1
    end
    if completed == 0 || total == 0
      0
    else
      ((completed + 0.0) / (total + 0.0)).floor
    end
  end
end
