$(document).on "turbolinks:load", ->
  do ->
    new TagIt

class TagIt
  constructor: ->
    $("#tag-it").tagit()
