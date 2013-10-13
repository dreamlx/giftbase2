# api用法：
    api 是restful格式
    除了注册，登录用户外，所有api都需要 auth_token（注册或者登录会返回这个token）
    #因为我用的zsh，所以有的时候会在url上加上转义'/'，比如在问号或者等号前加‘/’,请根据自己sh情况修改demo url
     => profiles.json\?auth_token\=q1d9skvy7yPqUajzhj4V

===

## 注册用户, 指定性别 gender
    curl -H "Accept:application/json" -d "user[avatar_id]=2&user[username]=11test&user[email]=test012@kingaxis.com&user[password]=123456&user[password_confirmation]=123456&user[gender]=m" http://0.0.0.0:3000/users
    
    => {"success":true,"auth_token":"q1d9skvy7yPqUajzhj4V"}
    
    #如用户名或者email重复
    => {"success":false}

## Login, 可以是 user[email] 或者 user[login]
    curl -H "Accept:application/json" -d "user[login]=test@kingaxis.com&user[password]=123456" http://0.0.0.0:3000/users/sign_in

    => {"success":true,"auth_token":"q1d9skvy7yPqUajzhj4V"}

    #API无需注销，因为是无会话的，登录后，iOS App 获得auth_token，然后可以保存在本地一直用。
    #iOS App 注销的时候，把本地保存的 auth_token 清除，就算注销了。

##My profile
    curl http://0.0.0.0:3000/api/profiles.json\?auth_token\=q1d9skvy7yPqUajzhj4V
    
    => {"id":2,"email":"test@kingaxis.com"}

## 更新profile
    curl -X PUT "http://0.0.0.0:3000/api/profiles.json?auth_token=7NZPuMgEWzBNjQ8EAcUc" -d "parent_name=sdfad"

    => {"avatar":{"url":"/assets/fallback/default.png","thumb":{"url":"/assets/fallback/default.png"}},"avatar_id":null,"birthday":null,"created_at":"2013-09-11T18:19:22+08:00","email":"test012@kingaxis.com","gender":"m","home_address":null,"id":98,"parent_name":"sdfad","qq":"1111","role":null,"school_address":null,"school_name":null,"updated_at":"2013-09-12T23:40:43+08:00","username":"11test"}%    

    url：http://0.0.0.0:3000/api/profiles.json

    method：put

新增参数：

    qq,parent_name, birthday(yy-mm-dd), school_address,school_name,home_address, email
    qq号码，家长名字，生日（年月日），学校地址，学校名字，家庭地址, email(需要前端校验email格式)

===
# 试卷访问层级
年级 grade-> 学习单元stage-> 试卷 unit

## api_grades      GET     /api/grades
    curl http://gifted-center.com/api/grades.json
    action: GET
    result: 所有年级，包括年级下的课程单元

## api_grade      GET     /api/grades/:id
    curl http://gifted-center.com/api/grades/1.json
    action: GET
    result: 获取id号为1的年级和年级下的单元json

## api_stage     GET     /api/stage/:id
    curl http://gifted-center.com/api/stages/1.json
    action: GET
    result: 获取id号为1课程单元和单元内的试卷json

## api_units 	GET    	/api/units(.:format)		
    curl http://gifted-center.com/api/units
    action: GET
    result: json, 所有试卷

## api_unit 	GET    	/api/units/:id(.:format)	
    curl http://gifted-center.com/api/units/1  
    action: GET
    result: 获取id号为1的试卷json内容

## api_unit_question_groups GET /api/units/:unit_id/question_groups(.:format) 
    curl http://gifted-center.com/api/units/1/question_groups
    action: GET
    result: 当前试卷的题目分组和所有题目（试卷由若干题目组构成，每个题目组有若干题目）

## api_unit_question_group GET    /api/units/:unit_id/question_groups/:id(.:format) 
    curl http://gifted-center.com/api/units/1/question_groups/1
    action: GET
    result: 当前试卷id号为1的分组和分组下的所有题目

## api/exams#create POST   /api/exams(.:format)   
    curl -d "exam" http://gifted-center.com/api/exams
    action: POST
    result: 提交做题结果                                                                                             
## api_exam#show GET    /api/exams/:id(.:format)
    curl http://gifted-center.com/api/exams/1
    action: GET
    result: 看id号为1的考试结果           
                                                                                            


