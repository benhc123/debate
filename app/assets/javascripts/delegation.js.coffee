$ ->
  $('.delegations-form .delegations').on 'change', ->
    className = $(this).find(':selected').parent().attr('label')
    $(this).parent().parent().find('input[type=hidden]').val(className)
