$(document).on "turbolinks:load", ->
  do ->
    new StaffMemberForm

class StaffMemberForm
  constructor: ->
    $('.AppForm__customer_form #is-enable-password-field').on
      'click': handlePasswordInputFieldOn
    $('.AppForm__customer_form #is-disable-password-field').on
      'click': handlePasswordInputFieldOff

  handlePasswordInputFieldOn = ->
    $('#is-enable-password-field').hide()
    $('#is-disable-password-field').show()
    $('#staff_member_password').removeAttr('disabled')
    $('label[for=staff_member_password]').addClass('required')

  handlePasswordInputFieldOff = ->
    $('#is-disable-password-field').hide()
    $('#is-enable-password-field').show()
    $('#staff_member_password').attr('disabled','disabled')
    $('label[for=staff_member_password]').removeClass('required')
