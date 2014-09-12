function timed(len, name) {
  $("#untimed").hide();
  $("#ex_name").text(name);
  $("#timer").removeClass("rest");
  $("#timer").addClass("timed");
  $("#timer").show()
  total_mil_secs = len;
  setTimer(len);
  startTimer();
}

function untimed(name, reps) {
  $("#timer").hide();
  $("#ex_name").text(name);
  $("#reps").text(reps);
  $("#untimed").show();
}

function rest(len) {
  $("#untimed").hide();
  $("#ex_name").text("Rest");
  $("#timer").addClass("rest");
  $("#timer").removeClass("timed");
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
    if (cat == "timed") {
      timed(parseInt(ex.dur), ex.name);}
    else if (cat == "untimed") {
      untimed(ex.name, ex.reps);}
    else if (cat  == "rest") {
      rest(parseInt(ex.dur));}
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
