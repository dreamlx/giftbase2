Grade.find(1).questions.each do |q|
  q2 = Question2.where("id=?",q).first
  unless q2.nil?
    q.subject = q2.subject
    q.save
    q.single_choice_options.each do |o|
      o2= SingleChoiceOption2.find(o)
      o.content = o2.content
      o.position = o2.position
      o.correct = o2.correct
      o.save
    end
  end
end