$(document).ready(function() {
	$('.section').popover();
  return $('.section').hover(function(event) {
    return $(this).toggleClass("hover");
  });
});