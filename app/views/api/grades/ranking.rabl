collection @users_exam
node(:user_id){ |user_exam| user_exam["user_id"] }
node(:avg_point){ |user_exam| user_exam["avg_point"]}
node(:avg_duration){ |user_exam| user_exam["avg_duration"]}
node(:accuracy){ |user_exam| user_exam["accuracy"]}