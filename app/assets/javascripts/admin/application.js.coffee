#= require jquery
#= require jquery_ujs
#= require bootstrap

#= require admin/questions

#= require_self

$ ->
  $("#q_stage_grade_id_eq").change ()->
    grade_id = $('#q_stage_grade_id_eq option:selected').val()
    $('#q_stage_id_eq').empty()
    $('#q_stage_id_eq').append("<option value=''>全部</option>")
    if grade_id
      $.getJSON "/api/grades/#{grade_id}.json", (json)->
        for stage in json.stages
          $('#q_stage_id_eq').append("<option value='#{stage.id}'>#{stage.name}</option>")
    else
      $.getJSON "/api/stages.json", (stages)->
        for stage in stages
          $('#q_stage_id_eq').append("<option value='#{stage.id}'>#{stage.name}</option>")
