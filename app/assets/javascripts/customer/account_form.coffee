$(document).on "turbolinks:load", ->
  do ->
    new AccountForm

class AccountForm
  constructor: ->
    $('.AppForm__customer-form input#form_inputs_home_address').on
      'click' : handleHomeAddressFields
    $('.AppForm__customer-form input#form_inputs_work_address').on
      'click' : handleWorkAddrssFields

  handleHomeAddressFields = ->
    toggleHomeAddressFields()
  handleWorkAddrssFields = ->
    toggleWorkAddressFields()

  toggleHomeAddressFields = ->
    checked = $('input#form_inputs_home_address').prop('checked')
    $('fieldset#home-address-fields input').prop('disabled', !checked)
    $('fieldset#home-address-fields select').prop('disabled', !checked)
    $('fieldset#home-address-fields').toggle(checked)
  toggleWorkAddressFields = ->
    checked = $('input#form_inputs_work_address').prop('checked')
    $('fieldset#work-address-fields input').prop('disabled', !checked)
    $('fieldset#work-address-fields select').prop('disabled', !checked)
    $('fieldset#work-address-fields').toggle(checked)