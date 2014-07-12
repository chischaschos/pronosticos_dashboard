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
