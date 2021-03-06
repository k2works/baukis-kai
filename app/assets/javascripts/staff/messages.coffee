$(document).on "turbolinks:load", ->
  do ->
    new Message

class Message
  constructor: ->
    if $('#number-of-unprocessed-messages').length
      window.setInterval(update_number_of_unprocessed_messages, 100 * 60)

  update_number_of_unprocessed_messages = ->
    $.get window.path_for("count_staff_messages"), (data) ->
      $('#number-of-unprocessed-messages').text "(#{data})"