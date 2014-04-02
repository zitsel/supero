$(function() {
	var brandList = $("#brandList").data("list");
	$( "input[id$='_brand']" ).autocomplete({
		source: brandList
	});
});
