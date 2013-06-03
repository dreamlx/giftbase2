# api用法：
    api 是restful格式

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
                                                                                            


