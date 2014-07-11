d3.json('/api/days_status', function(error, json) {

  var daysPerAgency = {};

  json.forEach(function(sale) {
    var key = sale[0] || 'NA';
    daysPerAgency[key] = daysPerAgency[key] || [];
    daysPerAgency[key].push(sale);
  });

  var agencyIndex = 0;
  var svg = d3.select('body').append('svg');

  for (var key in daysPerAgency) {

    var dayWidth = 120;

    var rects = svg.selectAll('rect.agency' + agencyIndex)
      .data(daysPerAgency[key])
      .enter()
      .append('rect')
      .classed('agency' + agencyIndex, true)
      .attr({
        width: dayWidth,
        height: 20,
        x: function(datum, index) {
          return index * (dayWidth + 5);
        },
        y: function(datum, index) {
          return agencyIndex * 25;
        },
        fill: function(datum, index) {
          if (datum[2] == 'complete') {
            return 'green';
          } else if (datum[2] == 'incomplete') {
            return 'yellow';
          } else {
            return 'red';
          }
        }
      });


    svg.selectAll('text.agency' + agencyIndex)
      .data(daysPerAgency[key])
      .enter()
      .append('text')
      .classed('agency' + agencyIndex, true)
      .text(function(datum) {
        return datum[0] + ' ' + datum[1];
      })
      .attr({
        x: function(datum, index) {
          return index * (dayWidth + 5) + 3;
        },
        y: function(datum, index) {
          return agencyIndex * 25 + 13;
        },
        'font-family': 'sans-serif',
        'font-size': '11px',
        fill: 'white'
      });

    agencyIndex += 1;
  }

});
