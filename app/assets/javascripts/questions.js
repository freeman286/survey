$(document).ready(function() {
	$('.section').popover();
  return $('.section').hover(function(event) {
    return $(this).toggleClass("hover");
  });
	
	$('#yes').click(function(event) {
	  $.ajax({
			$('#yes').html("<a href='#' class='btn btn-success'>Yes</a>");
			$('#no').html("<a href='#' class='btn'>No</a>");
		});
	});
	
	$('#no').click(function(event) {
	  $.ajax({
			$('#no').html("<a href='#' class='btn btn-danger'>No</a>");
			$('#yes').html("<a href='#' class='btn'>Yes</a>");
		});
	});
});