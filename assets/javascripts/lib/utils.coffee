window.dbg = (obj) ->
  $('body').append('<pre>'+JSON.stringify(obj, null, '\t')+'</pre>')

window.dbg3 = (obj) ->
  $('body').append('<pre>'+obj+'</pre>')

window.dbg2 = (node) ->
  tmpNode = document.createElement( "div" )
  tmpNode.appendChild( node.cloneNode( true ) )
  str = tmpNode.innerHTML
  tmpNode = node = null
  escapedStr = str.replace( "<" , "&lt;" ).replace( ">" , "&gt;")
  $('body').append('<pre>'+escapedStr+'</pre>')

###
window.currency_for = (el) ->
  el.formatCurrency({
    symbol: '<%= AppConfig.currency %>',
		positiveFormat: '<%= I18n.t('number.currency.format.format').sub('u','s') %>'
		negativeFormat: '(<%= I18n.t('number.currency.format.format').sub('u','s') %>)'
		decimalSymbol: '<%= I18n.t('number.currency.format.delimiter') %>'
		digitGroupSymbol: '<%= I18n.t('number.currency.format.separator') %>'
		roundToDecimalPlace: 0
  })
###

$.fn.serializeObject = () ->
  o = {}
  a = this.serializeArray()
  $.each(a, () ->
    if (o[this.name] != undefined)
      if (!o[this.name].push)
        o[this.name] = [o[this.name]]
      o[this.name].push(this.value || '')
    else
      o[this.name] = this.value || ''
  )
  return o

window.post = (url, data, success = null) ->
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        success: success,
        dataType: "json",
        contentType: "application/json",
        processData: false
    })

window.sticky = () ->
    y = $(window).scrollTop()
    if y > $('header').height()
      height = $('nav.topbar').css({
        'position': 'fixed'
        'top': '0'
        'width': $('#page').width()
        'box-shadow': '0px 20px 20px -15px #CCC'
      }).height()
      $('#container').css({
        'padding-top': height
      })
    else
      $('nav.topbar').removeAttr('style')
      $('#container').removeAttr('style')


String.prototype.model = () ->
  return can.capitalize( this.replace( /[-_]([a-z])/ig, (z,b) ->
    return b.toUpperCase()
  ))


window.generateWord = (limit) ->
    password = ''
    limit = limit || 8
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    list = chars.split('')
    len = list.length
    i = 0
    while ++i < limit
      index = Math.floor(Math.random() * len)
      password += list[index]

    return password

window.addUI = (el) ->
    el.addClass("ui-widget ui-widget-content ui-helper-clearfix").find(".tit").addClass("ui-widget-header").end()
    return el
