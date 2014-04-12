$(document).ready(function() {
  $('form').on('submit', function(e) {
//    e.preventDefault();
//    var wfaResponse = callWFA($('#drinks').val(), $('#hours').val(), $('#sex').val(), $('#weight').val());
  });


  var callWFA = function(drinks, hours, sex, weight) {
    var url = 'http://api.wolframalpha.com/v2/query?appid=***REMOVED***';
    var query = 'BAC ' + drinks + ' drinks ' + hours + ' hours ' + sex.toLowerCase() + ' ' + weight + 'lb';
    console.log(query);
    $.get(url, { 'input': query, 'format': 'plaintext'},

        function(data) {
          debugger;
          console.log(data);
        }
    );
  }

});
