jQuery ->
  updateSort = ->
  $("ul.upload").sortable(
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
    )
  $(document).on('click','.addEtsy', ( ->
    $("#upload_#{this.id}").clone().appendTo($('#etsyBox'));
    updateSort
  ));
  $(document).on('click','.dropEtsy', ( ->
    $(this).parent().remove();
  ));
