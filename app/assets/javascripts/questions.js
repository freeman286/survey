$(document).ready(function() {
	
	$('.yes').click(function(event) {
		var btn = $(this)
		id = btn.data('id')
		alert(id)
		$('.yes.'+id).addClass("btn-success");
		$('.no.'+id).removeClass("btn-danger")
	});
	
	$('.no').click(function(event) {
		var btn = $(this)
		id = btn.data('id')
		alert(id)
		$('.yes.'+id).removeClass("btn-success");
		$('.no.'+id).addClass("btn-danger")

	});
	$('.section').popover();
  
	return $('.section').hover(function(event) {
    return $(this).toggleClass("hover");
  });

});