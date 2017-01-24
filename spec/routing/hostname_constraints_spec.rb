require 'rails_helper'

#ルーティング
describe 'Routes' do
  # 職員トップページ
  it 'should route staff top page' do
    expect(get: 'http://baukis-kai.example.com/staff').to route_to(
                                         host: 'baukis-kai.example.com',
                                         controller: 'staff/top',
                                         action: 'index'
                                     )
  end

  # 管理者ログインフォーム
  it 'should route administrator login form' do
    expect(get: 'http://baukis-kai.example.com/admin/login').to route_to(
                                         host: 'baukis-kai.example.com',
                                         controller: 'admin/sessions',
                                         action: 'new'
                                     )
  end

  # ホスト名が対象外ならerrors/not_foundへ
  it 'should route errors/not_found giving exempt host' do
    expect(get: 'http://foo.example.com').to route_to(
                                                controller: 'errors',
                                                action: 'routing_error'
                                            )
  end

  # 存在しないパスならerrors/not_foundへ
  it 'should route errors/not_found giving a path that does not exist' do
    expect(get: 'http://baukis-kai.example.com/xyz').to route_to(
                                             controller: 'errors',
                                             action: 'routing_error',
                                             anything: 'xyz'
                                         )
  end
end