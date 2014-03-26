#= require active_admin/base
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.ui.all
//= require colorbox-rails
//= require jquery.turbolinks
//= require turbolinks
//= require jquery.Jcrop
jQuery ->
  $('#upload_uploaded_file').attr('name','upload[uploaded_file]')
  $('#new_upload').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png|mov|mpeg|mpeg4|avi)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_upload').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find(".progress").text(progress+'%')
         
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

