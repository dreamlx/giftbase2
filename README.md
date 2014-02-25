### updated 2014-2-25
## add task, set_default_question_level
rake utils:set_default_question_level

### updated 2013-12-11
##增加task，使之前没有验证的admin的email通过验证
rake utils:confirm_admin_email

### updated 2013-09-22
## purchase 支付api
前提要求账号内有现金
    
    curl -X POST http://127.0.0.1:3000/api/stages/3/purchase.json\?auth_token\=7NZPuMgEWzBNjQ8EAcUc 

    url: api/stages/id/purchase.json #id 是stage的id，数字
    action: POST
    返回结果：success、failed




###updated 2013-09-10
##unit,stage,grade错题统计
    curl -X GET http://127.0.0.1:3000/api/exams/wrong_answers.json?auth_token=L1M1NXGpFayafaQasky7 -d "exam_id=1" 
    curl -X GET http://127.0.0.1:3000/api/exams/wrong_answers.json?auth_token=L1M1NXGpFayafaQasky7 -d "grade_id=1" 
    curl -X GET http://127.0.0.1:3000/api/exams/wrong_answers.json?auth_token=L1M1NXGpFayafaQasky7 -d "stage_id=1" 
    curl -X GET http://127.0.0.1:3000/api/exams/wrong_answers.json?auth_token=L1M1NXGpFayafaQasky7 -d "unit_id=129" 
 
##unit,stage,grade 排名统计
    curl -X GET http://127.0.0.1:3000/api/ranks/ranking.json?auth_token=L1M1NXGpFayafaQasky7 -d "grade_id=1"
    curl -X GET http://127.0.0.1:3000/api/ranks/ranking.json?auth_token=L1M1NXGpFayafaQasky7 -d "stage_id=1"
    curl -X GET http://127.0.0.1:3000/api/ranks/ranking.json?auth_token=L1M1NXGpFayafaQasky7 -d "unit_id=1"

###updated 2013-07-30

## 注册用户, 指定性别 gender
    curl -H "Accept:application/json" -d "user[avatar_id]=2&user[username]=11test&user[email]=test012@kingaxis.com&user[password]=123456&user[password_confirmation]=123456&user[gender]=m" http://0.0.0.0:3000/users
    
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

## 更新profile
    curl -X PUT "http://0.0.0.0:3000/api/profiles.json?auth_token=7NZPuMgEWzBNjQ8EAcUc" -d "parent_name=sdfad"

    => {"avatar":{"url":"/assets/fallback/default.png","thumb":{"url":"/assets/fallback/default.png"}},"avatar_id":null,"birthday":null,"created_at":"2013-09-11T18:19:22+08:00","email":"test012@kingaxis.com","gender":"m","home_address":null,"id":98,"parent_name":"sdfad","qq":"1111","role":null,"school_address":null,"school_name":null,"updated_at":"2013-09-12T23:40:43+08:00","username":"11test"}%    

url：http://0.0.0.0:3000/api/profiles.json?auth_token=7NZPuMgEWzBNjQ8EAcUc

method：put

新增参数：

    qq,parent_name, birthday(yy-mm-dd), school_address,school_name,home_address, email
    qq号码，家长名字，生日（年月日），学校地址，学校名字，家庭地址, email(需要前端校验email格式)
## 上传头像
    curl -X PUT "http://0.0.0.0:3000/api/profiles.json?auth_token=MWWyUxtjqBhWE45p41Jk" -F "avatar=@/Users/dreamlinx/Downloads/1.jpg"
  
    =>{"avatar":{"url":"/uploads/user/avatar/5/1.jpg","thumb":{"url":"/uploads/user/avatar/5/thumb_1.jpg"}},"created_at":"2013-07-31T16:19:51+08:00","email":"test@kingaxis.com","id":5,"role":null,"updated_at":"2013-07-31T16:50:52+08:00"}%
