require 'rails_helper'

describe Staff::TopController, 'Before login' do
  let(:staff_member) { create(:staff_member) }

  before do
    session[:staff_member_id] = staff_member.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    # 通常はstaff/top/indexを表示
    it 'should display staff/top/index' do
      get :index
      expect(response).to render_template('staff/top/index')
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