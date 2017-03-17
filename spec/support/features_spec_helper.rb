module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.baukis_kai
    Capybara.app_host = 'http://' + config[namespace][:host]
  end

  def login_as_staff_member(staff_member, password = 'pw')
    visit staff_login_path
    within('.Login--staff') do
      fill_in I18n.t('activemodel.attributes.staff/login_form.email'), with: staff_member.email
      fill_in I18n.t('activemodel.attributes.staff/login_form.password'), with: password
      click_button I18n.t('staff.sessions.new.submit')
    end
  end

  def login_as_customer(customer, password = 'pw')
    visit customer_login_path
    within('.Login--customer') do
      fill_in I18n.t('activemodel.attributes.customer/login_form.email'), with: customer.email
      fill_in I18n.t('activemodel.attributes.customer/login_form.password'), with: password
      click_button I18n.t('customer.sessions.new.submit')
    end
  end
end