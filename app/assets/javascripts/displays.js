$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: '/surveys/sleep_data',
  dataType: 'json',
  success: function (received_data) {
    console.log(received_data);
    draw_sleep_graph(received_data);
  },
  error: function (result) {
    alert("Error loading sleep chart data, sorry!");
  }
});

function draw_sleep_graph(raw_hash){
  //way better to do this in rails, but want the js practice
  var key;
  var dataset = [];
  for (key in raw_hash) {
    dataset.push({'name': key, 'value': raw_hash[key] });
  }

  var maxValue = 700;
  var maxBars = 10;

  var w = 800;
  var h = 100;
  var barPadding = 1;
  var highlightBelow = 450; //sleep goal of 7.5h
  var barW = w / dataset.length;
  var scaledown = h / maxValue;

  var svg = d3.select("div#sleep-graph")
    .append("svg")
    .attr("width", w)
    .attr("height", h + 50); //leave room for titles

  svg.selectAll("svg")
    .data(dataset)
    .enter()
    .append("rect")
    .attr({
      x: function(d,i) { return i * (barW); },
      y: function(d) { return h - d.value*scaledown; },
      width: barW - barPadding,
      height: function(d) { return d.value*scaledown; }
    })
    .style({
      fill: function(d) { 
        if (d.value < highlightBelow) { return "red"; }
      }
    });

  //readable values
  svg.selectAll("svg")
    .data(dataset)
    .enter()
    .append("text")
    .text(function(d) {
      return d.value;
    })
    .attr({
      "font-family": "sans-serif",
      "font-size": "11px",
      "text-anchor": "middle",
      fill: function(d) {
        if (d.value > maxValue / 5) {return "white";}
        else {return "black"}
      },
      x: function(d,i) { 
        return (i * barW) + (barW / 2);
      },
      y: function(d) { 
        // before, numbers were getting cut off
        if (d.value > maxValue / 5) {return h - d.value*scaledown + 15;} // in bars
        else {return h - d.value*scaledown - 5;} // over bars
      }
    });

  //dates as a guide to when sleep took place
  svg.selectAll("svg")
    .data(dataset)
    .enter()
    .append("text")
    .text(function(d) {
      return d.name;
    })
    .attr({
      "font-family": "sans-serif",
      "font-size": "11px",
      "text-anchor": "middle",
      "fill": "black",
      x: function(d,i) { 
        return (i * barW) + (barW / 2);
      },
      y: function() {
        return (h + 25);
      }
    });

}