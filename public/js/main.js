$(document).ready(function() {
  var clock = $('#countdown').FlipClock({
    'autoStart': false,
    'countdown': true
  });

  var setCountdown = function(){
    var secondsToFinish, countdownFinished;

    countdownFinished = $('#countdown_to')[0].innerHTML;
    secondsToFinish = (Date.parse(countdownFinished) - Date.now()) / 1000;
    return secondsToFinish
  };

  clock.setTime(setCountdown());
  clock.start();
});
