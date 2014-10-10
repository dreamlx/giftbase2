### udated 2014-5-25
## grade.json
get api/grades.json

如果没有参数就是返回状态为publish的年级
如果参数 state=all 返回所有年级，可以用于测试

### updated 2014-5-21
## wrong answer redo
post api/exams/redo
类似于做题后提交。题目做对后，就不再出现了。

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
    curl http://0.0.0.0:3000/api/profiles.json/about_me\?auth_token\=q1d9skvy7yPqUajzhj4V
    
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


---
### url
    http://42.120.9.87:4010/

### status
    status is in response.status

# curl
### user
get (the user info)
```
curl -X GET -d "auth_token=EZwg2pcWyu3iXRXEsKyE" http://42.120.9.87:4010/api/users/1
```
get (the user profile)
```
curl -X GET -d "auth_token=EZwg2pcWyu3iXRXEsKyE" http://42.120.9.87:4010/api/users/profile

```
post (create a new user account)
```
curl -X POST -d "user[username]=ken&user[email]=wangkun025@gmail.com&user[password]=11111111" http://42.120.9.87:4010/api/users
```
put (update the user info)
```
change username
curl -X PUT -d "auth_token=EZwg2pcWyu3iXRXEsKyE&user[username]=wong" http://42.120.9.87:4010/api/users/1
change avatar
curl -X PUT -F "auth_token=EZwg2pcWyu3iXRXEsKyE" -F "user[avatar]=@/home/ken/Pictures/download.jpg" http://42.120.9.87:4010/api/users/1
```
get (user list)
```
no api for this
```
delete( destroy the user)
```
no api for this
```
### user_token
post (login)
```
curl -X POST -d "user[login]=wong&user[password]=11111111" http://42.120.9.87:4010/api/user_tokens
```
delete (logout)
```
curl -X DELETE http://42.120.9.87:4010/api/user_tokens/WZtk4nqj54KJQZsMTepY
```
### exam
```
curl -X GET http://42.120.9.87:4010/api/exams/question_group
```
### score
post ( create a new score)
```
curl -X POST -d "auth_token=7nZMyUDxrLujFdycCEn5&score["user_id"]=1&score["number"]=10" http://42.120.9.87:4010/api/scores
```
get (top ten)
```
curl -X GET http://42.120.9.87:4010/api/scores/topten
```
get (score list for the user login)
```
curl -X GET -d "auth_token=xC6wmisd1yp1JMXNaZaW" http://42.120.9.87:4010/api/scores
```
### version
```
curl -X GET http://42.120.9.87:4010/api/version
```
---
### user

    ## profile: [我的个人主页] 根据用户的authen_token，获取用户信息

      get "/api/users/profile", { auth_token: user.authentication_token}
      action: get

      参数: 
        auth_token

      返回:
        {
          "user" => {
            "avatar"    => { "url" => "url"},     ＃ 头像
            "username"  => "amo2",                ＃ 昵称
            "gender"    => "man",                 ＃ 性别
            "phone"     => "12345678901",         ＃ 手机
            "email"     => "c@gmail.com"          ＃ 邮箱
            "topscore"  => 90.0                   # 最高分
          }
        }

      status: 200

    ## create: [用户注册]
      curl -X POST -F "user[username]=amo2" -F "user[password]=11111111" -F "user[email]=c@gmail.com" http://42.120.9.87:4010/api/users
      post "/api/users", valid_params
      action: post

      参数:
        {
          "user" => {
            "username"  => "amo2",
            "password"  => "11111111",      # not empty
            "email"     => "c@gmail.com"    # not empty
          }
        } 

      返回:
        {
          "user" => {
            "avatar"    => { "url" => "url"},
            "username"  => "amo2",
            "gender"    => "man",
            "phone"     => "12345678901",
            "email"     => "c@gmail.com"
          },
          "auth_token" => user.authentication_token
        }        

      status:
        success: 201
        failed:  401

    ## update [更新用户资料]
    curl -X PUT -F "auth_token=7nZMyUDxrLujFdycCEn5" -F "user[username]=kk" http://42.120.9.87:4010/api/users/1
    curl -X PUT -F "auth_token=7nZMyUDxrLujFdycCEn5" -F "user[avatar]=@/home/ken/Pictures/download.jpg" http://42.120.9.87:4010/api/users/1
      put "/api/users/#{user.id}", { auth_token: user.authentication_token}
      action: put

      参数:
        {
          "user" => {
            "username"      => "amo2",                # 可选
            "gender"        => "man",                 # 可选
            "phone"         => "12345678901",         # 可选
            "school_name"   => "11111111",            # 可选
            "avatar"        => { "url" => "http//"}   # 可选
          },
          "auth_token" => user.authentication_token
        }
        
      返回:
        {
          "user" => {
            "avatar"    => { "url" => "url"},
            "username"  => "amo2",
            "gender"    => "man",
            "phone"     => "12345678901",
            "email"     => "c@gmail.com"
          }
        }   


### user_token

    ## show: [根据存储的token，获取用户信息]

      get "/api/user_tokens/#{ user.authentication_token }"

      参数:
        user.authentication_token

      返回:
        {
          "user" => {
            "id"        => 1,
            "avatar"    => { "url" => "url"},
            "username"  => "amo2",
            "gender"    => "man",
            "phone"     => "12345678901",
            "email"     => "c@gmail.com"
          },
          "auth_token" => "sfdstregd4345%fd",
          "message" => "user.authentication_token"
        }

      status: 200

    ## create: [用户登录] 输入登录信息，创建用户的token，该token保存在前端，用于其他行为的验证。

      post "/api/user_tokens", {user: { login: user.email| user.username, password: user.password}}

      参数:
        {
          "user" => {
            "login"     => user.email | user.username,
            "password"  => user.password,
          }
        }

      返回:
        {
          "user_token" => {
            "token" => "sfeter654376^$%80",
            "user_id" => user.id
          },
          "users" =>
          [{
            "id"        => user.id,
            "email"     => user.email,
            "username"  => user.name
          }
          ]
        }

      status:
        success: 201
        email or password is null: 400 { "error" => "The request must contain the user email and password."}
        user not found: 401, { "errors" => { "user" => ['用户不存在']}}
        password not match: 401, { "errors" => { "password" => ['密码错误']}}

    ## destroy:

      delete "/api/user_tokens/#{ user.authentication_token }"

      参数: 
        user.authentication_token

      返回:
        {
          "user" => {
            "id"        => 1,
            "avatar"    => { "url" => "url"},
            "username"  => "amo2",
            "gender"    => "man",
            "phone"     => "12345678901",
            "email"     => "c@gmail.com"            
          },
          "message" => "auth_token is empty now"
        }

      status: 
        success: 204
        user not found: 404 { "error" => "Invalid token"}

### question_group [随机获取题目列表] 如果题目数量大于250，即取250，否则取全部题目

    ## get question_group
      get "/api/exams/question_group", {auth_token: user.authentication_token}

      参数: 
        auth_token: user.authentication_token
        

      返回:
        {
          "question_group" => {
            [
              {
              "id"=>7611,                                               ＃ 题目的id
              "image"=>                                                 ＃ 题目图片
               {"url"=>"/assets/fallback/default.png",        
                "thumb"=>{"url"=>"/assets/fallback/default.png"}},
              "question_level_id"=>1,                                   ＃ 题目难度，目前没用
              "subject"=>"subject 21",                                  ＃ 题干
              "options"=>                                               ＃ 选项
               [{"content" => "Suscipit eligendi consequatur.",           ＃ 选项内容
                 "correct"=>false,                                        ＃ 是不是正确答案
                 "id"=>10041,                                             ＃ 选项id
                 "image"=>                                                ＃ 选项图片
                  {"url"=>"/assets/fallback/default.png",
                   "thumb"=>{"url"=>"/assets/fallback/default.png"}},
                 "position"=>82,                                          ＃ 应该是排序用的，目前不使用
                 "question_id"=>7611,                                     ＃ 关联的题目 id
                 "sequence"=>nil                                          ＃ 暂时不使用字段
                },
                ...
                 ]
                }
                ...
            ]
          }
        }

      status: 200
### Score

    ## index  获取某个人的分数历史
      get "/api/scores", {"auth_token" => user1.authentication_token}

      参数: 
        auth_token: user.authentication_token

      返回:
        {
          "scores" => {
            [
              {
                "id"            => 1,
                "user_id"       => 1,
                "number"        => 50,
                "created_at"    => "2014-09-10T15:04:43+08:00"
              },
              {
                "id"            => 2,
                "user_id"       => 1,
                "number"        => 45,
                "created_at"    => "2014-09-10T15:04:43+08:00"
              }
              ...
            ]
          }
        }

      status: 200

    ## topten 获取分数最高的10个
      get "/api/scores/topten"

      参数:
        no

      返回:
        {
          "scores" => {
            [
              {
                "id"            => 1,
                "username"      => "ken",
                "number"        => 50,
                "time"          => "2014-09-10T15:04:43+08:00"
              },
              {
                "id"            => 2,
                "username"      => "wong",
                "number"        => 45,
                "time"          => "2014-09-10T15:04:43+08:00"
              }
              ...
            ]
          }

        status: 200
        

    ## create 创建分数
      post "/api/scores", {"auth_token" => "7nZMyUDxrLujFdycCEn5" "score" => {"user_id" => user.id, "number" => 10}}
      

      参数:
        {
          "authen_token" => "7nZMyUDxrLujFdycCEn5",
          "score" => {
            "user_id"   => 1,
            "number"    => 10
          }
        }

      返回:
        {
          "score" => {
            "id"        => 4,
            "user_id"   => 1,
            "number"    => 10,
            "created_at"=> "2014-09-10T15:04:43+08:00"
          }
        }

      status:
        success: 201
        user_id is nil: 422 {"user" => ["不能为空"]}
        number  is nil: 422 {"number" => ["不能为空"]}

