$(document).ready(function() {
  $('.chosen-select').chosen(
    {
      no_results_text: "No results :("
    }
  );
});

$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: '/surveys/sleep_data',
  dataType: 'json',
  data: "{}", 
  success: function (received_data) {
    alert(received_data);
    //var div_where_to_draw = "div.mygraph";
    //draw_sleep_graph(div_where_to_draw, received_data);
  },
  error: function (result) {
    alert(result);
  }
});

function draw_sleep_graph(where_to_draw, data_to_draw){
  //Your d3js code here
}