###updated 2013-09-06
##unit,stage,grade错题统计
    curl -X POST http://127.0.0.1:3000/api/exams/wrong_answers/?auth_token=L1M1NXGpFayafaQasky7 -d "grade_id=1&user_id=15" 
    curl -X POST http://127.0.0.1:3000/api/exams/wrong_answers/?auth_token=L1M1NXGpFayafaQasky7 -d "stage_id=1&user_id=15" 
    curl -X POST http://127.0.0.1:3000/api/exams/wrong_answers/?auth_token=L1M1NXGpFayafaQasky7 -d "unit_id=129&user_id=15" 
 
##unit,stage,grade 排名统计
    curl -X POST http://127.0.0.1:3000/api/ranks/ranking/?auth_token=L1M1NXGpFayafaQasky7 -d "grade_id=1"
    curl -X POST http://127.0.0.1:3000/api/ranks/ranking/?auth_token=L1M1NXGpFayafaQasky7 -d "stage_id=1"
    curl -X POST http://127.0.0.1:3000/api/ranks/ranking/?auth_token=L1M1NXGpFayafaQasky7 -d "unit_id=1"

###updated 2013-07-30

## 注册用户, 指定性别 gender
    curl -H "Accept:application/json" -d "user[email]=test01@kingaxis.com&user[password]=123456&user[password_confirmation]=123456&user[gender]=m" http://0.0.0.0:3000/users
    
    => {"success":true,"auth_token":"q1d9skvy7yPqUajzhj4V"}
    
    #如用户名或者email重复
    => {"success":false}

## Login, 可以是 user[email] 或者 user[login]
    curl -H "Accept:application/json" -d "user[login]=test@kingaxis.com&user[password]=123456" http://0.0.0.0:3000/users/sign_in

    => {"success":true,"auth_token":"q1d9skvy7yPqUajzhj4V"}

API无需注销，因为是无会话的，登录后，iOS App 获得auth_token，然后可以保存在本地一直用。
iOS App 注销的时候，把本地保存的 auth_token 清除，就算注销了。

##My profile
    curl http://0.0.0.0:3000/api/profiles.json\?auth_token\=q1d9skvy7yPqUajzhj4V
    
    => {"id":2,"email":"test@kingaxis.com"}

## 上传头像
    curl -X PUT "http://0.0.0.0:3000/api/profiles.json?auth_token=MWWyUxtjqBhWE45p41Jk" -F "avatar=@/Users/dreamlinx/Downloads/1.jpg"
  
    =>{"avatar":{"url":"/uploads/user/avatar/5/1.jpg","thumb":{"url":"/uploads/user/avatar/5/thumb_1.jpg"}},"created_at":"2013-07-31T16:19:51+08:00","email":"test@kingaxis.com","id":5,"role":null,"updated_at":"2013-07-31T16:50:52+08:00"}%
