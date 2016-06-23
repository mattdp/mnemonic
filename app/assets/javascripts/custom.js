$(document).ready(function() {
  $('.chosen-select').chosen(
    {
      no_results_text: "No results :("
    }
  );
});

//for sleep chart - not yet scoped to only pages using the chart
$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: '/surveys/sleep_data',
  dataType: 'json',
  success: function (received_data) {
    draw_sleep_graph(received_data);
  },
  error: function (result) {
    alert("Error loading sleep chart data, sorry!");
  }
});

function draw_sleep_graph(data_to_draw){
  var maxValue = 700;
  var maxBars = 10;
  var dataset = data_to_draw;

  var w = 600;
  var h = 700;
  var barPadding = 1;
  var highlightAbove = 60;
  var barW = w / dataset.length;

  var svg = d3.select("body")
    .append("svg")
    .attr("width", w)
    .attr("height", h);

  svg.selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr({
      x: function(d,i) { return i * (barW); },
      y: function(d) { return h - d; },
      width: barW - barPadding,
      height: function(d) { return d; }
    })
    .style({
      fill: function(d) { 
        if (d > highlightAbove) { return "red"; }
      }
    });

  svg.selectAll("text")
    .data(dataset)
    .enter()
    .append("text")
    .text(function(d) {
      return d;
    })
    .attr({
      "font-family": "sans-serif",
      "font-size": "11px",
      "text-anchor": "middle",
      fill: function(d) {
        if (d > maxValue / 5) {return "white";}
        else {return "black"}
      },
      x: function(d,i) { 
        return (i * barW) + (barW / 2);
      },
      y: function(d) { 
        // before, numbers were getting cut off
        if (d > maxValue / 5) {return h - d + 15;} // in bars
        else {return h - d - 5;} // over bars
      }
    });
}