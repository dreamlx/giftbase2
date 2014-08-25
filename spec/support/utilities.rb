def sign_in(user, options={})
  post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end