$(document).on "turbolinks:load", ->
  do ->
    new CustomerForm

class CustomerForm
  constructor: ->
    $('button#enable-password-field').on
      'click': handlePasswordInputFieldOn
    $('button#disable-password-field').on
      'click': handlePasswordInputFieldOff

  handlePasswordInputFieldOn = ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#form_customer_password').removeAttr('disabled')
    $('label[for=form_customer_password]').addClass('required')

  handlePasswordInputFieldOff = ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#form_customer_password').attr('disabled','disabled')
    $('label[for=form_customer_password]').removeClass('required')
