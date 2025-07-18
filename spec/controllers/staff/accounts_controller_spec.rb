require 'rails_helper'

describe Staff::AccountsController, 'Before login' do
  it_behaves_like 'a protected singular staff controller'
end

describe Staff::AccountsController do
  describe '#update' do
    let(:params_hash) { attributes_for(:staff_member) }
    let(:staff_member) { create(:staff_member) }

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    # email属性を変更する
    it 'should update email attributes' do
      params_hash.merge!(email: 'test@example.com')
      patch :update, params: { id: staff_member.id, staff_member: params_hash, commit: '更新' }
      staff_member.reload
      expect(staff_member.email).to eq('test@example.com')
    end

    # 例外ActionController::ParameterMissingが発生
    it 'should throw ActionController::ParameterMissing exception' do
      bypass_rescue
      expect { patch :update, params: { id: staff_member.id, commit: '更新' } }.to raise_error(ActionController::ParameterMissing)
    end

    # end_dateの値は書き換え不可
    it 'should writable end_data value' do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch :update, params: { id: staff_member.id, staff_member: params_hash, commit: '更新' }
      }.not_to change { staff_member.end_date }
    end
  end
end
