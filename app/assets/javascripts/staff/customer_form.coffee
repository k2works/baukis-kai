$(document).on "turbolinks:load", ->
  do ->
    new CustomerForm

class CustomerForm
  constructor: ->
    $('.AppForm__customer-form #is-enable-password-field').on
      'click': handlePasswordInputFieldOn
    $('.AppForm__customer-form #is-disable-password-field').on
      'click': handlePasswordInputFieldOff
    toggleHomeAddressFields()
    toggleWorkAddressFields()
    $('.AppForm__customer-form input#form_inputs_home_address').on
      'click' : handleHomeAddressFields
    $('.AppForm__customer-form input#form_inputs_work_address').on
      'click' : handleWorkAddrssFields

  handlePasswordInputFieldOn = ->
    $('#is-enable-password-field').hide()
    $('#is-disable-password-field').show()
    $('#form_customer_password').removeAttr('disabled')
    $('label[for=form_customer_password]').addClass('required')
  handlePasswordInputFieldOff = ->
    $('#is-disable-password-field').hide()
    $('#is-enable-password-field').show()
    $('#form_customer_password').attr('disabled','disabled')
    $('label[for=form_customer_password]').removeClass('required')
  handleHomeAddressFields = ->
    toggleHomeAddressFields()
  handleWorkAddrssFields = ->
    toggleWorkAddressFields()

  toggleHomeAddressFields = ->
    checked = $('input#form_inputs_home_address').prop('checked')
    $('fieldset#home-address-fields input').prop('disabled', !checked)
    $('fieldset#home-address-fields select').prop('disabled', !checked)
  toggleWorkAddressFields = ->
    checked = $('input#form_inputs_work_address').prop('checked')
    $('fieldset#work-address-fields input').prop('disabled', !checked)
    $('fieldset#work-address-fields select').prop('disabled', !checked)