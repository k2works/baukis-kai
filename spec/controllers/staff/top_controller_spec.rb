require 'rails_helper'

describe Staff::TopController, 'Before login' do
  let(:staff_member) { create(:staff_member) }

  # IPアドレスによるアクセス制限
  describe 'access restriction by IP address' do
    before do
      Rails.application.config.baukis_kai[:restrict_ip_address] = true
    end

    # 許可
    context 'with authorization' do
      it 'rendered top page' do
        AllowedSource.create!(namespace: 'staff', ip_address: '0.0.0.0')
        get :index
        expect(response).to render_template('staff/top/index')
      end
    end

    # 拒否
    context 'with rejection' do
      it 'rendered error page' do
        AllowedSource.create!(namespace: 'staff', ip_address: '192.168.0.*')
        get :index
        expect(response).to render_template('errors/forbidden')
      end
    end

    after do
      Rails.application.config.baukis_kai[:restrict_ip_address] = false
    end
  end
end

describe Staff::TopController, 'After login' do
  let(:staff_member) { create(:staff_member) }

  before do
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    # 通常はstaff/top/dashboardを表示
    it 'should display staff/top/dashboard' do
      get :index
      expect(response).to render_template('staff/top/dashboard')
    end

    # 停止フラグがセットされたら強制的にログアウト
    it 'should forced logout if suspended flag on' do
      staff_member.update_column(:suspended, true)
      get :index
      expect(session[:staff_member_id]).to be_nil
      expect(response).to redirect_to(staff_root_url)
    end

    # セッションタイムアウト
    it 'should session timeout' do
      session[:last_access_time] = Staff::Base::TIMEOUT.ago.advance(seconds: -1)
      get :index
      expect(session[:staff_member_id]).to be_nil
      expect(response).to redirect_to(staff_login_url)
    end
  end
end