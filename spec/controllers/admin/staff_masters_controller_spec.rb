require 'rails_helper'

describe Admin::StaffMembersController, 'Before login' do
  it_behaves_like 'a protected admin controller'
end

describe Admin::StaffMembersController do
  let(:params_hash) { attributes_for(:staff_member) }
  let(:administrator) { create(:administrator) }

  before do
    session[:administrator_id] = administrator.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#create' do
    # 職員一覧ページにリダイレクト
    it 'should redirect to StaffMember index page' do
      post :create, staff_member: params_hash
      expect(response).to redirect_to(admin_staff_members_url)
    end

    # 例外ActionController::ParameterMissingが発生
    it 'should raise ActionController::ParameterMissing exception' do
      bypass_rescue
      expect { post :create}.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe '#update' do
    let(:staff_member) { create(:staff_member) }

    # suspendedフラグをセットする
    it 'should set suspended flag' do
      params_hash.merge!(suspended: true)
      patch :update, id: staff_member.id, staff_member: params_hash
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    # hashed_passwordの値は書き換え不可
    it 'should not rewrite hashed_password' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: 'x')
      expect {
      patch :update, id: staff_member.id, staff_member: params_hash
      }.not_to change { staff_member.hashed_password.to_s }
    end
  end
end
