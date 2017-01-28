require 'rails_helper'

describe Staff::AccountsController do
  describe '#update' do
    let(:params_hash) { attributes_for(:staff_member) }
    let(:staff_member) { create(:staff_member) }

    before do
      session[:staff_member_id] = staff_member.id
    end

    # email属性を変更する
    it 'should update email attributes' do
      params_hash.merge!(email: 'test@example.com')
      patch :update, id: staff_member.id, staff_member: params_hash
      staff_member.reload
      expect(staff_member.email).to eq('test@example.com')
    end

    # 例外ActionController::ParameterMissingが発生
    it 'should throw ActionController::ParameterMissing exception' do
      bypass_rescue
      expect { patch :update, id: staff_member.id}.to raise_error(ActionController::ParameterMissing)
    end

    # end_dateの値は書き換え不可
    it 'should writable end_data value' do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch :update, id: staff_member.id, staff_member: params_hash
      }.not_to change { staff_member.end_date }
    end
  end
end
