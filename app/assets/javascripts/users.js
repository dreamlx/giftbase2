var tagList = [];

$(document).ready(function(){
    get_tags();
    var datetime = new Array();
    var time = new Array();
    for(var key in tagList) {
      datetime.push(key)
      time.push(tagList[key])
    }
    var data = {
      labels : datetime,
      datasets : [
        {
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : time
        }
      ]
    }
    myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)
});


function get_tags(){
    $.ajax({  
        cache: true,
        type: "GET",
        dataType:"json",
        async: false,
        url: document.URL,
        success: function(data) {
            tagList = data
        }
    });
}
