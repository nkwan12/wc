$(document).on("click", "input[type='number']", function() {
  $(this).select();
});

var noWorkoutName = "Please make sure this workout has a name before saving!";
var invalidExercise = "Please make sure that all exercises have a name and a duration greater than 0 before saving!";
var alertMsg = $(".alert-msg");

$(document).on("click", ".alert .close", function() {
  $(this).parent().hide();
});

$(document).on("click", ".submit-workout", function() {
  alertMsg = $(".alert-msg");
  if (validateWorkout()) {
    $(".workout-form").submit();
  } else {
    alertMsg.parent().show();
  };
});

var validateWorkout = function() {
  alertMsg.parent().hide();
  if ($(".workout-name").val() == "") {
    alertMsg.text(noWorkoutName);
    $(".workout-name").addClass("error");
    return false;
  } else {
    $(".workout-name").removeClass("error");
    returnVal = true;
    $(".exercise").each(function(i) {
      $(this).find("div").eq(1).removeClass("error");
      name = $(this).find(".exercise-name").val();
      mins = $(this).find(".dur-minutes").val();
      secs = $(this).find(".dur-seconds").val();
      if ((name == "") || ((mins + secs) == 0)) {
        alertMsg.text(invalidExercise);
        $(this).find("div").eq(1).addClass("error");
        returnVal = false;
      }
    });
    return returnVal;
  }
};

$(document).on('show.bs.modal', function(e) {
  console.log($(e.relatedTarget).data('href'));
  $(".delete-workout-btn").attr('href', $(e.relatedTarget).data('href'));
});
