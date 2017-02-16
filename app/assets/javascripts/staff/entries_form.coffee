$(document).on "turbolinks:load", ->
  do ->
    new EntriesForm

class EntriesForm
  constructor: ->
    $('.AppEntryForm--button-wrapper button#update-entries-button').on
      'click': handleEntriesButton

  handleEntriesButton = ->
    approved = []
    not_approved = []
    canceled = []
    not_canceled = []

    $('.AppEntryForm input.isApproved').each ->
      if $(this).prop('checked')
        approved.push $(this).data('entry-id')
      else
        not_approved.push $(this).data('entry-id')
    $('#form_approved').val(approved.join(':'))
    $('#form_not_approved').val(not_approved.join(':'))

    $('.AppEntryForm input.isCanceled').each ->
      if $(this).prop('checked')
        canceled.push $(this).data('entry-id')
      else
        not_canceled.push $(this).data('entry-id')
    $('#form_canceled').val(canceled.join(':'))
    $('#form_not_canceled').val(not_canceled.join(':'))

    $('.AppEntryForm--button-wrapper form').submit()

