$ = jQuery
$(document).on 'rails_admin.dom_ready', ->
  $('.sidebar-nav').affix()
  console.log 'ici'