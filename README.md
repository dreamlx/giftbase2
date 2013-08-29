###updated 2013-08-27
## unit,stage,grade的排名

http://127.0.0.1:3000/api/grades/ranking.json/?id=1&order_type=1
id为grade的id,order_type为排序的方式，1 是avg_ponit根据平均分排名 2.accuracy根据正确率来排名 3.avg_duration 根据评价时间来排名

http://127.0.0.1:3000/api/grades/ranking.json/?id=1&order_type=1
http://127.0.0.1:3000/api/units/order.json/?auth_token=L1M1NXGpFayafaQasky7&id=10

###updated 2013-08-26

## 对于exam的错题统计
curl -X GET "http://127.0.0.1:3000/api/exams/135/error.json/?auth_token=L1M1NXGpFayafaQasky7"
135为exam的id

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
