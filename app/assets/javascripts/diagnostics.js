$(document).ready(function() {
	return $('.section').hover(function(event) {
		return $(this).toggleClass("hover");
	});
	
	$('#show-content').click(function(event) {
		event.preventDefault();
		alert("works");
	});
});