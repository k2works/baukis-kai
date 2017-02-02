$(document).on "turbolinks:load", ->
  do ->
    new StaffMemberForm

class StaffMemberForm
  constructor: ->
    $('#enable-password-field').on
      'click': handlePasswordInputFieldOn
    $('#disable-password-field').on
      'click': handlePasswordInputFieldOff

  handlePasswordInputFieldOn = ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#staff_member_password').removeAttr('disabled')
    $('label[for=staff_member_password]').addClass('required')

  handlePasswordInputFieldOff = ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#staff_member_password').attr('disabled','disabled')
    $('label[for=staff_member_password]').removeClass('required')
