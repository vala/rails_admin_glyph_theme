fileUploadTemplate = """
<div class=\"fileupload fileupload-new\" data-provides=\"fileupload\">
  <div class=\"input-append\">
    <div class=\"uneditable-input span3\">
      <i class=\"icon-file fileupload-exists\"></i>
      <span class=\"fileupload-preview\"></span>
    </div>
    <span class=\"btn btn-file\">
      <span class=\"fileupload-new\">Sélectionnez</span>
      <span class=\"fileupload-exists\">Changer</span>
    </span>
    <a class=\"btn fileupload-exists\" data-dismiss=\"fileupload\" href=\"#\">Supprimer</a>
  </div>
</div>
"""

spinnerTemplate = """
<div class='spinner-buttons btn-group btn-group-vertical'>
  <button class='btn spinner-up' type='button'>
    <i class='icon-chevron-up'></i>
  </button>
  <button class='btn spinner-down' type='button'>
    <i class='icon-chevron-down'></i>
  </button>
</div>
"""

$ ->
  # Hack for Ipad
  $("body").on "touchstart.dropdown", ".dropdown-menu", (e) ->
    e.stopPropagation()

  # input custom constructor
  inputConstructor = ->
    $form = $("form")

    $inputFile = $("input[type=\"file\"]")
    $inputFile.each ->
      $this = $(this)

      $alreadyDone = $this.parent().find('.fileupload-exists')
      $uploadedFile = $this.parent().find('a').addClass('uploaded-file').remove()
      if $alreadyDone.length
      else
        $container = $this.parent().html(fileUploadTemplate)
        # Append input to file buttons
        $container.find(".btn-file").append(this)
        # Add preview link if existing
        $container.prepend($uploadedFile) if $uploadedFile.length


    $spinner = $form.find("input[type=\"number\"]")
    $spinner.each ->
      $this = $(this)
      $alreadyDone = $this.parent('.spinner')
      console.log $alreadyDone
      if $alreadyDone.length
      else
        $this.addClass "spinner-input"
        $spinner_wrapper = $this.wrap("<div class='spinner'/>")
        $(spinnerTemplate).insertAfter $this

    $(".spinner").spinner()

  # Constructor when page is juste reaload
  inputConstructor()

  # Constructor when page is loaded by pjax
  $(document).on "pjax:end", ->
    inputConstructor()

  $(document).on 'nested:fieldAdded',->
    inputConstructor()

