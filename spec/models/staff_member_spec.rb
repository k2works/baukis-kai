# == Schema Information
#
# Table name: staff_members # 職員
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null               # メールアドレス
#  email_for_index  :string(255)      not null               # 索引用メールアドレス
#  family_name      :string(255)      not null               # 姓
#  given_name       :string(255)      not null               # 名
#  family_name_kana :string(255)      not null               # 姓（カナ）
#  given_name_kana  :string(255)      not null               # 名（カナ）
#  hashed_password  :string(255)                             # パスワード
#  start_date       :date             not null               # 開始日
#  end_date         :date                                    # 終了日
#  suspended        :boolean          default("0"), not null # 停止フラグ
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_staff_members_on_email_for_index                       (email_for_index) UNIQUE
#  index_staff_members_on_family_name_kana_and_given_name_kana  (family_name_kana,given_name_kana)
#

require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    # 文字列を与えると、hashed_passwordは長さ60の文字列になる
    it 'is a string of length 60 of hashed_password when giving a string' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    # nilを与えると、hashed_passwordはnilになる
    it 'is nil of hashed_password when giving a nil' do
      member = StaffMember.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end

  describe 'normalization' do
    # email前後の空白を除去
    it 'remove spaces before and after email' do
      member = create(:staff_member, email: ' test@example.com')
      expect(member.email).to eq('test@example.com')
    end

    # emailに含まれる全角英数文字を半角に変換
    it 'converts full-width alphanumeric characters included in email to half-width characters' do
      member = create(:staff_member, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(member.email).to eq('test@example.com')
    end

    # email前後の全角スペースを除去
    it 'eliminates double-byte spaces before and after email' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end

    # family_name_kanaに含まれるひらがなをカタカナに変換
    it 'converts hiragana contained in family_name_kana to katakana' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    # family_name_kanaに含まれる半角カナを全角カナに変換
    it 'convertd Hankaku Kana included in family_name_kana to Full-width Kana' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq('テスト')
    end
  end

  describe 'validation' do
    # @を2個含むemailは無効
    it 'invalid email containing 2 @' do
      memeber = build(:staff_member, email: 'test@@example.com')
      expect(memeber).not_to be_valid
    end

    # 漢字を含むfamily_name_kanaは無効
    it 'is invalid which family_name_kana including kanji' do
      member = build(:staff_member, family_name_kana: '試験')
      expect(member).not_to be_valid
    end

    # 長音符を含むfamily_name_kanaは無効
    it 'is invalid which family_name_kana including long note' do
      member = build(:staff_member, family_name_kana: 'エリー')
      expect(member).to be_valid
    end

    # 他の職員のメールアドレスと重複したemailは無効
    it 'is invalid email which duplicate email address of other staff' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end

    # 漢字、ひらがな、カタカナ、アルファベット以外の文字を含まない
    it 'does not include characters other than kanji, hiragana, katakana, and alphabet in family_name' do
      member = build(:staff_member, family_name: '@@@')
      expect(member).not_to be_valid
    end

    it 'does not include characters other than kanji, hiragana, katakana, and alphabet in given_name' do
      member = build(:staff_member, given_name: '@@@')
      expect(member).not_to be_valid
    end

  end
end
