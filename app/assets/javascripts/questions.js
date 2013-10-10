$(document).ready(function() {
	
	$('.yesx').click(function(event) {
		var btn = $(this)
		id = btn.data('id')
		$('.yes.'+id).addClass("btn-success");
		$('.no.'+id).removeClass("btn-danger");
	});
	
	$('.nox').click(function(event) {
		var btn = $(this)
		id = btn.data('id')
		$('.yes.'+id).removeClass("btn-success");
		$('.no.'+id).addClass("btn-danger");

	});
	$('.section').popover();
  
	return $('.section').hover(function(event) {
    return $(this).toggleClass("hover");
  });

});