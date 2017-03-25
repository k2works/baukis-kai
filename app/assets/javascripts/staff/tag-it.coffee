$(document).on "turbolinks:load", ->
  do ->
    new TagIt

class TagIt
  constructor: ->
    $("#tag-it").tagit(
      afterTagAdded: (e, ui) ->
        unless ui.duringInitialization
          message_id = $("#tag-it").data('message-id')
          path = "#{window.paths.staff_root}/messages/#{message_id}/tag"
          $.post(path, {label: ui.tagLabel})
      afterTagRemoved: (e, ui) ->
        unless ui.duringInitialization
          message_id = $("#tag-it").data('message-id')
          path = "#{window.paths.staff_root}/messages/#{message_id}/tag"
          $.ajax(type: 'DELETE', url: path, data: { label: ui.tagLabel})
    )
