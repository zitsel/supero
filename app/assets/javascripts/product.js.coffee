jQuery ->
	$('#medium-image-container').zoom({target: '#image-zoom-container'});
	$(document).on('click','#medium-image-container', ( ->
		$('#image-zoom-container').toggle();
		)
	);
	$("#medium-image-container").mouseleave( ->
		$("#image-zoom-container").hide();
		)