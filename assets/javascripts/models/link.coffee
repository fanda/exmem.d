window.Link = can.Model({
  findAll : 'GET /links'

  findOne : 'GET /links/{id}'

  create  : (box, link) ->
    post('/board/'+box+'/new', link["_data"], (d) ->
        alert('success ' + d)
        #link.attr('id', id)
      , "json")

  update  : (attrs, link ) ->
    url = unescape('/links/{id}').replace('{id}', link.id)
    return $.post(url, attrs, null, "json")

  destroy : 'DELETE /links/{id}'


  init: () ->
    @validatePresenceOf ['title', 'url']

}, {



})

window.Link.List = can.Model.List({
  render: () ->
    _g = {}
    @each (link) ->
      first_letter = link.title[0]
      if (_g[first_letter] == undefined)
        _g[first_letter] = []
      _g[first_letter].push(link)
    #return _g
    return JST["javascripts/templates/Link_record"]({ items: _g })
})

window.Link.prototype.alert = () ->
  alert('alert.link')
