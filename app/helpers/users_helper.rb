module UsersHelper
  
  def exam_time(time)
  	if time > 60
  	  time = time / 60
  	  return "#{time} min"
  	else
  	  return "#{time} sec"
  	end
  end

end