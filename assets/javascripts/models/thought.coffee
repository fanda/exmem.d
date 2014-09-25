window.Thought = can.Model({

  findAll : 'GET /thoughts'

  findOne : 'GET /thoughts/{id}'

  create  : (attrs, thought) ->
    attrs['thought']['public'] = thought.attr('public')
    url = '/thoughts'
    return $.post(url, attrs, (id) ->
        thought.attr('id', id)
      , "json")

  update  : (attrs, thought ) ->
    attrs['thought']['public'] = thought.attr('public')
    url = unescape('/thoughts/{id}').replace('{id}', thought.id)
    return $.post(url, attrs, null, "json")

  destroy : 'DELETE /thoughts/{id}'

  init: () ->
    @validatePresenceOf ['text']


}, {

  setPublic: (newval) ->
    if typeof newval == 'boolean'
      return newval
    else
      if newval == 'Public'
        return true
      return false

})

window.Thought.prototype.alert = () ->
  alert('alert.thought')
