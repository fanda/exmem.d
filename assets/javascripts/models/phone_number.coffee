window.PhoneNumber = can.Model({
  findAll : 'GET /phone_numbers'

  findOne : 'GET /phone_numbers/{id}'

  create  : (attrs, phone_number) ->
    url = '/phone_numbers'
    return $.post(url, attrs, (id) ->
        phone_number.attr('id', id)
      , "json")

  update  : (attrs, phone_number) ->
    url = unescape('/phone_numbers/{id}').replace('{id}', phone_number.id)
    return $.post(url, attrs, null, "json")

  destroy : 'DELETE /phone_numbers/{id}'

  init: () ->
    @validatePresenceOf ['name', 'number']

}, {})

window.PhoneNumber.List = can.Model.List({
  render: () ->
    _g = {}
    @each (item) ->
      first_letter = item.name[0]
      if (_g[first_letter] == undefined)
        _g[first_letter] = []
      _g[first_letter].push(item)
    return JST["javascripts/templates/PhoneNumber_record"]({ items: _g })
})

window.PhoneNumber.prototype.alert = () ->
  alert('alert.phone_number')
