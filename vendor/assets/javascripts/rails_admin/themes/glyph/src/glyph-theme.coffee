class FileUploadBuilder
  template:
    """
    <div class=\"fileinput fileinput-new input-group\" data-provides=\"fileinput\">
      <div class=\"span3 control-fileinput form-control\" data-trigger=\"fileinput\">
        <i class=\"icon-file fileinput-exists\"></i>
        <span class=\"fileinput-filename\"></span>
      </div>
      <span class=\"btn btn-default btn-file\">
        <span class=\"fileinput-new\">Sélectionnez</span>
        <span class=\"fileinput-exists\">Changer</span>
      </span>
      <a class=\"btn btn-default fileinput-exists\" data-dismiss=\"fileinput\" href=\"#\">Supprimer</a>
    </div>
    """
    
  constructor: (@$el) ->
    $uploadedFile = @$el.parent().find('a, img').addClass('uploaded-file').remove()
    $uploadedHint = @$el.parent().parent().find('.help-block').remove()

    unless @$el.data("file-upload")
      $container = @$el.parent().parent().find('.toggle').html(@template)
      # Append input to file buttons
      $container.find(".btn-file").append(@$el)
      # Add preview link if existing
      $container.prepend($uploadedFile) if $uploadedFile.length
      $container.append($uploadedHint)
      # Store object in "file-upload" data key on dom element
      @$el.data("file-upload", this)


class SpinnerBuilder
  template:
    """
    <div class='spinner-buttons btn-group btn-group-vertical'>
      <button class='btn spinner-up' type='button'>
        <i class='icon-chevron-up'></i>
      </button>
      <button class='btn spinner-down' type='button'>
        <i class='icon-chevron-down'></i>
      </button>
    </div>
    """

  # input custom constructor
  constructor: (@$el) ->
    unless @$el.data("spinner")
      @$el.addClass "spinner-input"
      $spinner_wrapper = @$el.wrap("<div class='spinner'/>")
      $(@template).insertAfter @$el
      # @$el.closest(".spinner").spinner('value')
      # Store object in "spinner" data key on dom element
      @$el.data("spinner", this)


class SelectBuilder
  # input custom constructor
  constructor: (@$el) ->
    $jquerySelect = @$el.closest('.controls').find('.filtering-select')
    if $jquerySelect.length
    else
      unless @$el.data("select")
        $jqueryMultiSelect = @$el.closest('.controls').find('.ra-multiselect').remove()
        @$el.closest('select').selectize()

        @$el.data("select", this)


class FormInputs
  fieldTypes:
    'input[type="file"]': FileUploadBuilder
    'input[type="number"]': SpinnerBuilder
    'select': SelectBuilder

  constructor: (@selector, options = {}) ->
    # # Constructor when nested field is added
    $(document).on "nested:fieldAdded", =>
      @$el = $(@selector)
      @processFields()

    @$el = $(@selector)
    @processFields()

  processFields: ->
    $.each @fieldTypes, (selector, klass) =>
      @$el.find(selector).each ->
        new klass($(this))

$(document).on "rails_admin.dom_ready", ->
  # Add class
  $("body.rails_admin").addClass 'glyph-theme-js'

  # Hack for Ipad
  $("body").on "touchstart.dropdown", ".dropdown-menu", (e) ->
    e.stopPropagation()

  # Form Inputs constructor
  new FormInputs("form")
