$(document).on 'turbolinks:load', ->
  $('form.edit_form').on 'click', '#enable-password-field', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#form_customer_password').removeAttr('disabled')
    $('label[for=form_customer_password]').addClass('required')
  $('form.edit_form').on 'click', '#disable-password-field', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#form_customer_password').attr('disabled', 'disabled')
    $('label[for=form_customer_password]').removeClass('required')
  toggle_home_address_fields() # 定義した関数の読み込み
  toggle_work_address_fields() # HTML文書の読み込み完了後に行われる
  $('input#form_inputs_home_address').on 'click', ->
    toggle_home_address_fields()
  $('input#form_inputs_work_address').on 'click', ->
    toggle_work_address_fields()

# 関数の定義
toggle_home_address_fields = ->
  checked = $('input#form_inputs_home_address').prop('checked')
  $('fieldset#home-address-fields').toggle(checked)

toggle_work_address_fields = ->
  checked = $('input#form_inputs_work_address').prop('checked')
  $('fieldset#work-address-fields').toggle(checked)
