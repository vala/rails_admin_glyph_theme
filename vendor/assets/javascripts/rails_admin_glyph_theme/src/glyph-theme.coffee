class FileUploadBuilder
  template:
    """
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

  constructor: (@$el) ->
    $uploadedFile = @$el.parent().find('a, img').addClass('uploaded-file').remove()

    unless @$el.data("file-upload")
      $container = @$el.parent().html(@template)
      # Append input to file buttons
      $container.find(".btn-file").append(@$el)
      # Add preview link if existing
      $container.prepend($uploadedFile) if $uploadedFile.length
      # Store object in "file-upload" data key on dom element
      @$el.data("file-upload", this)


class CheckboxBuilder
  constructor: (@$el) ->
    unless @$el.data("checkbox")
      @$el.wrap('<label class="checkbox"/>')
      @$el.closest('.checkbox').prepend("<span class='icon'></span><span class='icon-to-fade'></span>")
      @$el.closest(".checkbox").on 'click', ->
        setupLabel()
      setupLabel()
      # Store object in "checkbox" data key on dom element
      @$el.data("checkbox", this)


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
      @$el.closest(".spinner").spinner()
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
        @$el.closest('select').selectpicker()
        # Store object in "spinner" data key on dom element
        @$el.data("select", this)



class FormInputs
  fieldTypes:
    'input[type="file"]': FileUploadBuilder
    'input[type="number"]': SpinnerBuilder
    'input[type="checkbox"]:visible': CheckboxBuilder
    'select': SelectBuilder

  constructor: (@selector, options = {}) ->
    # # Constructor when page is loaded by pjax
    $(document).on "ready pjax:end nested:fieldAdded", =>
      @$el = $(@selector)
      @processFields()

  processFields: ->
    $.each @fieldTypes, (selector, klass) =>
      @$el.find(selector).each ->
        new klass($(this))


$ ->
  # Hack for Ipad
  $("body").on "touchstart.dropdown", ".dropdown-menu", (e) ->
    e.stopPropagation()

  # Add class
  $("body.rails_admin").addClass 'glyph-theme-js'

  # Form Inputs constructor
  new FormInputs("form")

  # Toggle checkbox list & export
  $(document).on "click", "#list input.toggle", ->
    $("#list [name='bulk_ids[]']").prop("checked", $(this).is(":checked")).closest('.checkbox').toggleClass('checked')

  $(document).on "click", "#fields_to_export label input#check_all", ->
    elems = $("#fields_to_export label input")
    $checbox_checked = $("#fields_to_export label input#check_all").is(":checked")
    if $checbox_checked
      $(elems).closest('.checkbox').addClass 'checked'
      $(elems).prop "checked", true
    else
      $(elems).closest('.checkbox').removeClass 'checked'
      $(elems).prop "checked", false