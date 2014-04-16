$(document).ready(function() {
  var clock = $('#countdown').FlipClock({
    'autoStart': false
  });

  clock.setTime();
});
