#TODO list
1. 单选和多选，api输出需要增加image_url => json
4. 班级处理
5. 重构排名，ranking
        <%= link_to t("ranking", scope: "ranking_type"), ranking_admin_ranks_path(unit_id: unit.id) %>
6. 
<%= link_to t("take_exam", scope: "crud"), new_exam_path(:unit_id => unit.id)  %>