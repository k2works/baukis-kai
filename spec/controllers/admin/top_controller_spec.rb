require 'rails_helper'

describe Admin::TopController, 'Before login' do
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