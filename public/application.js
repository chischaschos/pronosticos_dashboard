var Graph = function(data, label) {
  var margin = {top: 20, right: 30, bottom: 40, left: 40},
      width = 400 - margin.left - margin.right,
      height = 200 - margin.top - margin.bottom;

  var xScale = d3.scale.ordinal().rangeRoundBands([0, width], .1);
  var yScale = d3.scale.linear().range([height, 0]);

  var xAxis = d3.svg.axis().scale(xScale).orient('bottom');
  var yAxis = d3.svg.axis().scale(yScale).orient('left');

  var chart = d3.select('body').append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

  xScale.domain(data.map(function(datum) { return datum.date; }));
  yScale.domain([0, d3.max(data, function(datum) { return datum.to_pay_total; })]);

  yAxis.tickFormat(function(datum) { return '$' + (datum / 1000) + 'K'; });

  chart.append('g')
      .attr('class', 'axis')
      .attr('transform', 'translate(0,' + height + ')')
      .call(xAxis)
    .append('text')
      .attr('class', 'label')
      .attr("transform", 'translate(' + width / 2 + ', 30)')
      .text(label);

  chart.append('g')
    .attr('class', 'axis')
    .call(yAxis);

  chart.selectAll('.bar')
      .data(data)
    .enter().append('rect')
      .attr('class', 'bar')
      .attr('x', function(datum) { return xScale(datum.date); })
      .attr('y', function(datum) { return yScale(datum.to_pay_total); })
      .attr('height', function(datum) { return height - yScale(datum.to_pay_total); })
      .attr('width', xScale.rangeBand());

}

d3.json('/api/totals/monthly', function(error, json) {
  for (var agency in json) {
    Graph(json[agency], 'Agency ' + agency + ' sales');
  }

  var accumulatedNumbers = [];

  for (var agency in json) {
    json[agency].forEach(function(fields, index) {
      accumulatedNumbers[index] = accumulatedNumbers[index] || {date: fields.date, to_pay_total: 0, commission: 0};
      accumulatedNumbers[index].to_pay_total += fields.to_pay_total;
      accumulatedNumbers[index].commission += fields.commission;
    });
  };

  Graph(accumulatedNumbers, 'Accumulated sales');
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
