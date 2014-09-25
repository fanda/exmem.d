window.RSSBox = can.Model({

  findAll : 'GET /rss_boxes'

  findOne : 'GET /rss_boxes/{id}'

  destroy : 'DELETE /rss_boxes/{id}'

  create  : (attrs, rss_box) ->
    url = '/rss_boxes'
    return $.post(url, attrs, (id) ->
        rss_box.attr('id', id)
      , "json")

  update  : (attrs, rss_box ) ->
    url = unescape('/rss_boxes/{id}').replace('{id}', rss_box.id)
    return $.post(url, attrs, null, "json")


  #init: () ->
  #  @validatePresenceOf ['text']


}, {

})

window.RSSBox.prototype.alert = () ->
  alert('alert.rss_box')
