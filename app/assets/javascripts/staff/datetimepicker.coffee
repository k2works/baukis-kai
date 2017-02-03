$(document).on "turbolinks:load", ->
  do ->
    $(".birthday-picker").datetimepicker(
      locale: 'ja'
      format : 'YYYY-MM-DD'
    )
