function timed(len, name) {
  $("#untimed").hide();
  $("#ex_name").text(name);
  $(body).css("background-color", "green")
  $("#timer").show()
  total_mil_secs = len;
  setTimer(len);
  startTimer();
}

function untimed(name, reps) {
  $("#timer").hide();
  $("#ex_name").text(name);
  $("#reps").text(reps);
  $(body).css("background-color", "green")
  $("#untimed").show();
}

function rest(len) {
  $("#untimed").hide();
  $("#ex_name").text("Rest");
  $(body).css("background-color", "blue")
  $("#timer").show()
  total_mil_secs = len;
  setTimer(len);
  startTimer();
}

function pause() {
  $("#untimed").hide();
  $("#timer").hide();
  $("#continue").show();
  $("#ex_name").text("Paused");
}

function next_ex() {
  ex = exers[ex_index];
  ex_index++;
  if (ex) {
    cat = ex.cat;
    if (cat == "Exercise") {
      timed(parseInt(ex.dur)*1000, ex.name);}
    else if (cat == "untimed") {
      untimed(ex.name, ex.reps);}
    else if (cat  == "Rest") {
      rest(parseInt(ex.dur)*1000);}
    else if (cat == "pause") {
      pause();}
  } else {
    $("#untimed").hide();
    $("#timer").hide();
    $("#ex_name").text("Done!");
  }
}

$(document).on("click", "#start_workout", function() {
  $("#start_workout").hide();
  next_ex();
});

$(document).on("click", "#continue", function() {
  $("#continue").hide();
  next_ex();
});
