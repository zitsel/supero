$(function() {
$('.thumb').click(function(e){
     e.preventDefault();
     var $new = $( this ).attr("src").replace('thumb','original');
    $("#medium-image").attr('src',$new);
    $(".zoom-image").attr('src',$new);
    $("#link_to_change").attr('href',$new);
	$('#medium-image-container').zoom({target: '#image-zoom-container'});
 });
  });
