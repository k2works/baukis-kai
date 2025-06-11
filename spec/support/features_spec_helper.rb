module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.baukis_kai
    # ローカルテスト用にlocalhost:3001を使用
    Capybara.app_host = "http://127.0.0.1:3001"
    # パスプレフィックスを設定（必要な場合）
    # Capybara.app_host = "http://localhost:3001/#{config[namespace][:path]}"
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

  def login_as_administrator(administrator, password = 'pw')
    visit admin_login_path
    within('.Login--admin') do
      fill_in I18n.t('activemodel.attributes.admin/login_form.email'), with: administrator.email
      fill_in I18n.t('activemodel.attributes.admin/login_form.password'), with: password
      click_button I18n.t('admin.sessions.new.submit')
    end
  end
end
