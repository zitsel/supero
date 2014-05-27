jQuery ->
	tt = $("#medium-image-container").tooltip({content: "click to zoom", track: true, "enable"})
	$('#medium-image-container').zoom({target: '#image-zoom-container'});
	$(document).on('click','#medium-image-container', ( ->
		$('#image-zoom-container').toggle();
		)
	);
	$( "#medium-image-container").mouseleave( ->
		$("#medium-image-container").tooltip({"close"})
		$("#image-zoom-container").hide();
		)


