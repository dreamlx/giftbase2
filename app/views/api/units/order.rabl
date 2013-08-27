collection @exams
attributes :id, :duration, :total_point
node(:unit_name) {|exam| exam.unit.try(:name)}
node(:user_id) {|exam| exam.user.try(:id)}
