var Graph = function(data) {
  var height = 200;
  var width = 400;
  var barPadding = 5;
  var yPadding = 10;
  var xPadding = 20;

  var svg = d3.select('body').append('svg').
    attr({
      height: height,
      width: width
    });
  var barWidth = (width - 2 * xPadding) / data.length - barPadding;

  var yScale = d3.scale.linear().
    domain([0, d3.max(data, function(datum) { return datum.to_pay_total; })]).
    range([height - yPadding, yPadding]);

  var xScale = d3.scale.linear().
    domain([0, data.length]).
    range([xPadding, width - xPadding]);

  var yAxis = d3.svg.axis().
    scale(yScale).
    orient('left');

  var xAxis = d3.svg.axis().
    scale(xScale).
    orient('bottom');

  svg.selectAll('rect').
    data(data).
    enter().
    append('rect').
    attr({
      x: function(datum, index) {
        return xScale(index) + xPadding;
      },
      y: function(datum) {
        return height - yPadding * 2 - (height - yScale(datum.to_pay_total) - yPadding) + 10;
      },
      width: function() {
        return barWidth;
      },
      height: function(datum) {
        return height - yScale(datum.to_pay_total) - yPadding - 10;
      },
      fill: function(datum) {
        return "rgb(0, 0, 0)";
      }
    });

  svg.selectAll('text').
    data(data).
    enter().
    append('text').
    classed('totalsLabel', true).
    text(function(datum) {
      return datum.to_pay_total;
    }).
    attr({
      x: function(datum, index) {
        return xScale(index) + xPadding + barWidth / 2;
      },
      y: function(datum) {
        return height - yPadding * 2 - (height - yScale(datum.to_pay_total) - yPadding) + 25;
      }
    });

  svg.append('g').attr({
    class: 'axis',
    transform: "translate(" + (xPadding * 2) + ", -" + yPadding +")"
  }).call(yAxis);
  svg.append('g').attr({
    class: 'axis',
    transform: "translate(" + xPadding + ", " + (height - yPadding * 2) + ")"
  }).call(xAxis);
}

d3.json('/api/totals/monthly', function(error, json) {
  for (var agency in json) {
    Graph(json[agency]);
  }

  var accumulatedNumbers = [];

  for (var agency in json) {
    json[agency].forEach(function(fields, index) {
      accumulatedNumbers[index] = accumulatedNumbers[index] || {date: fields.date, to_pay_total: 0, commission: 0};
      accumulatedNumbers[index].to_pay_total += fields.to_pay_total;
      accumulatedNumbers[index].commission += fields.commission;
    });
  };

  Graph(accumulatedNumbers);
});

d3.json('/api/days_status', function(error, json) {

  var daysPerAgency = {};

  json.forEach(function(sale) {
    var key = sale[0] || 'NA';
    daysPerAgency[key] = daysPerAgency[key] || [];
    daysPerAgency[key].push(sale);
  });

  var agencyIndex = 0;
  var svg = d3.select('body').append('svg').attr({"id": 'daysStatuses'});

  for (var key in daysPerAgency) {

    var dayWidth = 120,
        dayHeight = 20;

    svg.selectAll('.agency' + agencyIndex)
      .data(daysPerAgency[key])
      .enter()
      .append('rect')
      .classed('agency' + agencyIndex, true)
      .attr({
        width: dayWidth,
        height: 20,
        x: function(datum, index) {
          var column = index % 7;
          return column * dayWidth;
        },
        y: function(datum, index) {
          var row = Math.floor(index / 7);
          var translatedRow = row * 2 + 1 - agencyIndex;
          return translatedRow * dayHeight;
        },
        fill: function(datum, index) {
          if (datum[2] == 'complete') {
            return 'rgb(128, 208, 247)';
          } else if (datum[2] == 'incomplete') {
            return 'rgb(245, 245, 7)';
          } else {
            return 'rgb(247, 168, 129)';
          }
        }
      });

    svg.selectAll('.agencyLabel' + agencyIndex)
      .data(daysPerAgency[key])
      .enter()
      .append('text')
      .classed('agencyLabel' + agencyIndex, true)
      .text(function(datum) {
        return datum[0] + ' ' + datum[1];
      })
      .attr({
        x: function(datum, index) {
          var column = index % 7;
          return column * dayWidth + 3;
        },
        y: function(datum, index) {
          var row = Math.floor(index / 7);
          var translatedRow = row * 2 + 1 - agencyIndex;
          return translatedRow * dayHeight + 13;
        },
        'font-family': 'sans-serif',
        'font-size': '11px',
        fill: '#4f447f'
      });

    agencyIndex += 1;
  }

});
