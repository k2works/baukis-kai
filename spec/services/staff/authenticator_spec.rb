require 'rails_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    # 正しいパスワードならtrueを返す
    it 'should return true given valid password' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    # 誤ったパスワードならfalseを返す
    it 'should return false given invalid password' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    # パスワード未設定ならfalseを返す
    it 'should return false given nil password' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    # 停止フラグが立っていればfalseを返す
    it 'should return false given suspended true' do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    # 開始前ならfalseを返す
    it 'should return true given before start date' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    # 終了後ならfalseを返す
    it 'should return false given after end date' do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end