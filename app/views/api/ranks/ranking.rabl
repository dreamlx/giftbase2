
node(:all_users_avg_point){ @all_users_avg_point}
node(:all_users_sum_duration){ @all_users_sum_duration}

child(@users_ranking => :user_ranking) {
	node(:avg_point){ |rank| rank["avg_point"]}
	node(:avg_duration){ |rank| rank["avg_duration"]}
	node(:user_id){ |rank| rank["user_id"]}
}

