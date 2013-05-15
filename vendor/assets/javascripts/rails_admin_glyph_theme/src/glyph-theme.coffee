$ ->
  # Hack for Ipad
  $("body").on "touchstart.dropdown", ".dropdown-menu", (e) ->
    e.stopPropagation()

  initializePages = ->
    $form = $("form")

    $inputFile = $("input[type=\"file\"]")
    $inputFile.each ->
      $this = $(this)
      $this.parent().html("        <div class=\"fileupload fileupload-new\" data-provides=\"fileupload\">          <div class=\"input-append\">            <div class=\"uneditable-input span3\">              <i class=\"icon-file fileupload-exists\"></i>              <span class=\"fileupload-preview\"></span>            </div>            <span class=\"btn btn-file\">              <span class=\"fileupload-new\">Sélectionnez</span>              <span class=\"fileupload-exists\">Changer</span>            </span>            <a class=\"btn fileupload-exists\" data-dismiss=\"fileupload\" href=\"#\">Supprimer</a>          </div>        </div>").find(".btn-file").append this

    $spinner = $form.find("input[type=\"number\"]")
    $spinner.each ->
      $this = $(this)
      $this.addClass "spinner-input"
      $spinner_wrapper = $this.wrap("<div class='spinner'/>")
      $("<div class='spinner-buttons btn-group btn-group-vertical'>          <button class='btn spinner-up' type='button'>            <i class='icon-chevron-up'></i>          </button>          <button class='btn spinner-down' type='button'>            <i class='icon-chevron-down'></i>          </button>        </div>").insertAfter $this

    $(".spinner").spinner()

  initializePages()

  $(document).on "pjax:end", ->
    initializePages()

