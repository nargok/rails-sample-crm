# coding: utf-8
require 'rails_helper'

RSpec.describe 'ルーティング' do
  example '職員トップページ' do
    expect(get: 'http://baukis.example.com').to route_to(
                                                  host: 'baukis.example.com',
                                                  controller: 'staff/top',
                                                  action: 'index'
                                                )
  end

  example '管理者ログインフォーム' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
                                                  host: 'baukis.example.com',
                                                  controller: 'admin/sessions',
                                                  action: 'new'
                                                )
  end

  example 'ホスト名が対象外ならerrors/not_foundへ' do
    expect(get: 'http://foo.example.jp').to route_to(
                                              controller: 'errors',
                                              action: 'not_found'
                                                )

  end

  example '存在しないパスならerrors/not_foundへ' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
                                              controller: 'errors',
                                              action: 'not_found',
                                              anything: 'xyz'
                                                )

  end
end
