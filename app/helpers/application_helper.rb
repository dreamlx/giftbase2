module ApplicationHelper
  def st(translation)
    t(translation).html_safe
  end

  def format_error_message(errors)
    msg = String.new
    errors.each do |key, value|
      msg.concat(key.to_s)
      msg.concat(': ')
      msg.concat(value.to_s)
      msg.concat(' ')
    end
    msg.strip
  end
end
