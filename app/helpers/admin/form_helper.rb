module Admin::FormHelper
  def question_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |b|
      yield(b)
    end
    render('/admin/questions/add_fields', { name: name, id: id, fields: fields })
  end

  def admin_question_by_type_path(question, partial = '')
    if partial.blank?
      "/admin/questions/#{question.class.name.underscore}"
    else
      File.join("/admin/questions/#{question.class.name.underscore}", partial)
    end
  end

  def options_for_question_level
    (1..4).map { |index| [t(index.to_s, scope: 'question_level'), index] }
  end
end
