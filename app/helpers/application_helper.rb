module ApplicationHelper
	def flash_class(type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else
			""
		end
	end

	def flash_header(message)
	  if message == "You need to be registered to build your own diagnostic results. It won't take long and is free!"
	    "What Next?"
	  else
	    nil
	  end
  end

	def check_admin(user)
	  if !user.nil?
      user.is_admin?
    end
	end


  def segment_rows(diagnostic)
    html = ""
    diagnostic.segments.each do |segment|
      html << "<tr class='section'><td>#{segment.name}</td><td><a class='admin' href='/segments/#{segment.id}'>Show/Answer Segment</a></td></tr>"
    end
    html.html_safe
  end

  def crud_state_to_name(state)
    case state
    when "show"
      "Showing"
    when "new"
      "Creating"
    when "create"
      "Creating"
    when "edit"
     "Editing"
    when "update"
      "Update"
    else
      ""
    end
  end


  def percent_completed(x, y)
      if x == 0 && y == 0
        0
      else
        ((x + 0.0) / (y + 0.0) * 100).floor
      end
  end

  def previous_id_for_question(question)
    pos = 0
    loop_pos = 0
    question.segment.questions.each do |que|
      if que.id == question.id
        pos = loop_pos
      end
      loop_pos += 1
    end
    if pos == 0
      pos_s = 0
      loop_pos_s = 0
      question.segment.diagnostic.segments.each do |seg|
        if seg.id == question.segment.id
          pos_s = loop_pos_s
        end
        loop_pos += 1
      end
      if pos_s == 0
        question.segment.diagnostic.segments.last.questions.last.id
      else
        question.segment.diagnostic.segments[pos_s - 1].questions.last.id
      end
    else
      question.segment.questions[pos - 1].id
    end
  end
end
