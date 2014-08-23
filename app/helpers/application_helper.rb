module ApplicationHelper
  def st(translation)
    t(translation).html_safe
  end
end
