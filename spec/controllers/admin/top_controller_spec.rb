require 'rails_helper'

describe Admin::TopController, 'Before login' do
  let(:administrator) { create(:administrator) }

  # IPアドレスによるアクセス制限
  describe 'access restriction by IP address' do
    before do
      Rails.application.config.baukis_kai[:restrict_ip_addresses] = true
    end

    # 許可
    context 'with authorization' do
      it 'rendered top page' do
        AllowedSource.create!(namespace: 'admin', ip_address: '0.0.0.0')
        get :index
        expect(response).to render_template('admin/top/index')
      end
    end

    # 拒否
    context 'with rejection' do
      it 'rendered error page' do
        AllowedSource.create!(namespace: 'admin', ip_address: '192.168.0.*')
        get :index
        expect(response).to render_template('errors/forbidden')
      end
    end

    after do
      Rails.application.config.baukis_kai[:restrict_ip_addresses] = false
    end
  end
end

describe Admin::TopController, 'After login' do
  let(:administrator) { create(:administrator) }

  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    # 停止フラグがセットされたら強制的にログアウト
    it 'should forced logout if suspended flag on' do
      administrator.update_column(:suspended, true)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_root_url)
    end

    # セッションタイムアウト
    it 'should session timeout' do
      session[:last_access_time] = Admin::Base::TIMEOUT.ago.advance(seconds: -1)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_login_url)
    end
  end
end