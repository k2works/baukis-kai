$(document).on "turbolinks:load", ->
  do ->
    $(".datetimepicker").datetimepicker(
      locale: 'ja'
    )
