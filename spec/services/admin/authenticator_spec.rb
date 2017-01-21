require 'rails_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    # 正しいパスワードならtrueを返す
    it 'should return true given valid password' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    # 誤ったパスワードならfalseを返す
    it 'should return false given invalid password' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    # パスワード未設定ならfalseを返す
    it 'should return false given nil password' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end
    
    # 停止フラグが立っていてもtrueを返す
    it 'should return true given stop flag' do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
    
  end
end