var timer;
var startTime;

var decrement = function() {
  total_mil_secs -= 100;
  setTimer(total_mil_secs);
  if (total_mil_secs <= 0) {
    window.clearInterval(timer);
    next_ex();
  }
}

function pad(t) {
  return t > 9 ? t : "0" + t;
}

function setTimer(milsecs) {
  secs = Math.ceil(milsecs/1000);
  $("#minutes").text(Math.floor(secs/60));
  $("#seconds").text(pad(Math.ceil(secs%60)));
}

function startTimer() {
  window.clearInterval(timer);
  timer = window.setInterval(decrement, 100);
}

function stopTimer() {
  window.clearInterval(timer);
}

$(document).on("click", "#start_timer", function() {
  $("body").css("background-color", "green");
  startTime = Date.now();
  startTimer();
});
$(document).on("click", "#pause_timer", function() {
  $("body").css("background-color", "blue");
  stopTimer();
});

$(window).unload(function() {
  stopTimer();
  alert("Are you sure?");
});
