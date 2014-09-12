var timer;

var decrement = function() {
  total_mil_secs -= 100;
  setTimer(total_mil_secs);
  if (total_mil_secs == 0) {
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
  timer = window.setInterval(decrement, 100);
}

function stopTimer() {
  window.clearInterval(timer);
}

$(document).on("click", "#start_timer", function() {
  timer = window.setInterval(decrement, 100);
});
$(document).on("click", "#pause_timer", function() {
  window.clearInterval(timer);
});
