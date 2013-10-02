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
end
