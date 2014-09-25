#= require ./lib/jquery
#= require ./lib/jquery_ujs
#= require ./canjs/can.jquery
#= require ./canjs/can.observe.validations
#= require ./canjs/can.observe.setter
#= require ./lib/jquery_formparams
#= require ./lib/jquery_input_hint
#= require ./lib/jquery_paginate
#= require ./lib/jquery_slidernav
#= require ./lib/jquery_ui_custom
#= require ./lib/jquery_zrssfeed
#= require ./lib/json2
#= require ./lib/utils
#= require ./lib/facebox
#= require ./bootstrap_ini
#= require_tree ./models
#= require_tree ./controls
#= require_tree ./templates
#= require_self

$(document).ready ->

  $('a[rel*=facebox]').facebox({
    loading_image : 'loading.gif',
    close_image   : 'closelabel.gif'
  })

  new ControlApp('body', {})

  $('.box').each( () ->
    new ControlBox($(this), {})
  )

