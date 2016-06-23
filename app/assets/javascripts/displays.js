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

  var w = 800;
  var h = 100;
  var barPadding = 1;
  var highlightBelow = 450; //sleep goal of 7.5h
  var barW = w / dataset.length;

  var scaledown = h / maxValue;

  var svg = d3.select("div#sleep-graph")
    .append("svg")
    .attr("width", w)
    .attr("height", h);

  svg.selectAll("rect")
    .data(dataset)
    .enter()
    .append("rect")
    .attr({
      x: function(d,i) { return i * (barW); },
      y: function(d) { return h - d*scaledown; },
      width: barW - barPadding,
      height: function(d) { return d*scaledown; }
    })
    .style({
      fill: function(d) { 
        if (d < highlightBelow) { return "red"; }
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
        if (d > maxValue / 5) {return h - d*scaledown + 15;} // in bars
        else {return h - d*scaledown - 5;} // over bars
      }
    });
}