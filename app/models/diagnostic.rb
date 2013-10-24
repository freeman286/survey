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
    #g.theme = Gruff::Themes::THIRTYSEVEN_SIGNALS
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
    complete = 0
    total = 0
    self.segments.each do |seg|
      segment = seg.class.where(diagnostic_id: self.id, id: seg.id).first
      segment.questions.each do |que|
        question = que.class.where(segment_id: segment.id, id: que.id).first
        question.sub_questions.each do |sub|
          sub_question = sub.class.where(question_id: question.id, id: sub.id).first
          total += 1
          if sub_question.yes?(user) || sub_question.no?(user)
            complete += 1
          end
        end
      end
    end
    if complete == 0 || total == 0
      0
    else
      ((complete + 0.0) / (total + 0.0) * 100).floor
    end
  end

end
