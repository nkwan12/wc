$(document).on("click", ".add-exercise", function(e) {  
  var exer = $(".new_exercise").clone().removeClass("hidden new_exercise").addClass("exercise");
  $(".exercises").append(exer);
});
$(document).on("click", ".remove-exercise", function(e) {
  $(this).parent().remove();
});
$(document).on("change", "#exercise__cat", function() {
  if ($(this).val() == "Rest") {
    $(this).parent().next("div").find("input").prop("readOnly", true).val("Rest");
  } else {
    $(this).parent().next("div").find("input").prop("readOnly", false).val("");
  }
});
$(document).on("page:change", function() {$(".exercises").sortable();});
