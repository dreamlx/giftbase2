class FixOptionsPosition < ActiveRecord::Migration
  def up
    Question::SingleChoice.all.each do |q|
      q.single_choice_options.each_with_index do |o, i|
        o.set_list_position(i + 1)
      end
    end

    Question::MultipleChoice.all.each do |q|
      q.multiple_choice_options.each_with_index do |o, i|
        o.set_list_position(i + 1)
      end
    end
    
    Question::FillInBlank.all.each do |q|
      q.fill_in_blank_solutions.each_with_index do |o, i|
        o.set_list_position(i + 1)
      end
    end
  end

  def down
  end
end
