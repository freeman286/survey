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
end
