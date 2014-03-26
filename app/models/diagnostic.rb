class Diagnostic < ActiveRecord::Base
  
  include Magick
  
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
        g.data word_wrap(segment.name), segment.score_for_user(user_id)
      end
    end

    g.write("public/results/#{self.id}-#{user_id}.png")
  end
  
  def make_wheel
    inner_radius = 190
    inner_diameter = inner_radius * 2 
    border_width = 10
    spoke_width = 70
    hub_size = 40
    hub_margin = 10
    text_pos = 100
    total_diameter = inner_diameter + (2 * border_width)
    centre = total_diameter / 2
    gc = Image.new(total_diameter, total_diameter) { self.background_color = "transparent" }
    
    # Draw background
    circle = Magick::Draw.new 
    circle.fill('#f5f5f5')
    circle.ellipse(centre, centre, (inner_diameter + border_width)  / 2, (inner_diameter + border_width) / 2, 0, 360)
    circle.draw(gc)
    
    # Draw spokes
    segment_number = 0
    if self.segments.count > 0
      segment_gap = 360 / self.segments.count
    else
      segment_gap = 0
    end
    self.segments.each do |seg|
      line = Magick::Draw.new
      line.stroke('#d5d5d5')
      line.stroke_width(50)
      line.line(centre, centre, centre + (inner_radius + (border_width / 2)) * Math::cos(degrees_to_radians(segment_number * segment_gap)), centre + (inner_radius + (border_width / 2)) * Math::sin(degrees_to_radians(segment_number * segment_gap)))
      line.draw(gc)
      segment_number += 1
    end
    
    # Draw outline of circle
    circle = Magick::Draw.new
    circle.stroke('#e5e5e5')
    circle.stroke_width(border_width)
    circle.fill_opacity(0)
    circle.ellipse(centre, centre, (inner_diameter + border_width)  / 2, (inner_diameter + border_width) / 2, 0, 360)
    circle.draw(gc)

    
    # Draw centre hub
    hub = Magick::Draw.new
    hub.fill('#f5f5f5')
    hub.ellipse(centre, centre, hub_size, hub_size, 0, 360)
    hub.draw(gc)
    
    
    # Annotate spoke with text
    text_number = 0
    if self.segments.count > 0
      text_gap = 360 / self.segments.count
    else
      text_gap = 0
    end
    
    self.segments.each do |seg|
      line = 0
      text = word_wrap(seg.name, 20)
      rows = text.split("\n")
      if rows.count == 1
        rows.each do |row| 
          scratch_gc = Draw.new
          scratch_gc.pointsize(10)
          scratch_gc.font("assets/fonts/HelveticaNeue.ttf")
          metrics = scratch_gc.get_type_metrics(row)
          width = metrics.width 
          height = (metrics.bounds.y2 - metrics.bounds.y1).round
          indent = (inner_radius - hub_size - hub_margin - width ) / 2
          x = centre + (hub_margin + hub_size + indent) * Math::cos(degrees_to_radians(text_number * text_gap))
          y = centre + (hub_margin + hub_size + indent) * Math::sin(degrees_to_radians(text_number * text_gap))
          Draw.new.annotate(gc, 0, 0,x, y, "#{row}") {
            self.pointsize = 10
            self.font("assets/fonts/HelveticaNeue.ttf")
            self.rotation = text_gap * text_number
            line += 1
          }
        end    
        text_number += 1
      else
        rows.each do |row| 
          scratch_gc = Draw.new
          scratch_gc.pointsize(10)
          scratch_gc.font("assets/fonts/HelveticaNeue.ttf")
          metrics = scratch_gc.get_type_metrics(row)
          width = metrics.width 
          height = (metrics.bounds.y2 - metrics.bounds.y1).round
          indent = (inner_radius - hub_size - hub_margin - width ) / 2
          x = centre + (hub_margin + hub_size + indent) * Math::cos(degrees_to_radians(text_number * text_gap))
          y = centre + (hub_margin + hub_size + indent) * Math::sin(degrees_to_radians(text_number * text_gap))
          case text_gap * text_number
            when 0
              angle = 90 - (text_gap * text_number)
              x += a_adjust(angle, line, height, true)
              y += b_adjust(angle, line, height, true)
            when 90 
              angle = 90 - (text_gap * text_number)
              x += a_adjust(angle, line, height, false)
              y += b_adjust(angle, line, height, false)
            when 0..90
              angle = 90 - (text_gap * text_number)
              x += a_adjust(angle, line, height, false)
              y += b_adjust(angle, line, height, true)
            when 180
              angle = 90 - (text_gap * text_number)
               x += a_adjust(angle, line, height, true)
               y += b_adjust(angle, line, height, true)
            when 90..180
              angle = 90 - (270 - text_gap * text_number)
              x += b_adjust(angle, line, height, true)
              y += a_adjust(angle, line, height, false)
            when 270
              angle = 90 - (text_gap * text_number)
              x += a_adjust(angle, line, height, false)
              y += b_adjust(angle, line, height, false)
            when 180..270
              angle = 90 - (text_gap * text_number - 270)
              x += b_adjust(angle, line, height, true)
              y += a_adjust(angle, line, height, true)
            when 270..360
              angle = 90 - (360 - text_gap * text_number)
              x += a_adjust(angle, line, height, true)
              y += b_adjust(angle, line, height, true)
            end
            line += 1  
            Draw.new.annotate(gc, 0, 0, x, y, "#{row}") {
              self.pointsize = 10
              self.font("assets/fonts/HelveticaNeue.ttf")
              self.rotation = text_gap * text_number
            }
          end  
        text_number += 1
      end
    end
    
    
    gc.write("public/wheels/wheel_#{self.id}.png")
    
  end
  
  def segment_from_x_y_rotation(x,y,rotation)
    x_from_centre = x.to_f - 200
    y_from_centre = 200 - y.to_f
    
    if x_from_centre >= 0 && y_from_centre >= 0
      angle = 90 - radians_to_degrees(Math::atan(y_from_centre / x_from_centre)) - rotation.to_f
    elsif x_from_centre >= 0 && y_from_centre < 0
      angle = 90 - radians_to_degrees(Math::atan(y_from_centre / x_from_centre)) - rotation.to_f
    elsif x_from_centre < 0 && y_from_centre < 0
      angle = 270 - radians_to_degrees(Math::atan(y_from_centre / x_from_centre)) - rotation.to_f
    elsif x_from_centre < 0 && y_from_centre >= 0
      angle = 270 - radians_to_degrees(Math::atan(y_from_centre / x_from_centre)) - rotation.to_f
    else  
      angle = 0
    end
    
    
    if self.segments.count > 0
      segment_gap = 360 / self.segments.count
    else
      segment_gap = 360
    end
    segment_number =  ((angle - (segment_gap / 2)) / segment_gap).floor
    
    if self.segments.count > 7
      self.segments[segment_number - 1]
    else
      if rotation != 0
        self.segments[segment_number - 0.5]
      else
        self.segments[segment_number]
      end
    end
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
  
  private
  
  def degrees_to_radians(deg)
    deg * Math::PI / 180
  end
  
  def radians_to_degrees(rad)
    rad * 180 / Math::PI
  end
  
  def word_wrap(text, columns = 20)
    text.split("\n").collect do |line|
      line.length > columns ? line.gsub(/(.{1,#{columns}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
  
  def a_adjust(angle, line, height, positive)
    if positive
      if line == 0
        0 - ((height / 2) * Math::cos(degrees_to_radians(angle)))
      elsif line == 1         
        height * Math::cos(degrees_to_radians(angle))
      end
    else
      if line == 0
        (height / 2) * Math::cos(degrees_to_radians(angle))
      elsif line == 1         
        0 - (height * Math::cos(degrees_to_radians(angle)))
      end
    end
  end
  
  def b_adjust(angle, line, height, positive)
    if positive
      if line == 0
        0 - ((height / 2) * Math::sin(degrees_to_radians(angle)))
      elsif line == 1         
        height * Math::sin(degrees_to_radians(angle))
      end
    else
      if line == 0
        (height / 2) * Math::sin(degrees_to_radians(angle))
      elsif line == 1         
        0 - (height * Math::sin(degrees_to_radians(angle)))
      end 
    end
  end
end
