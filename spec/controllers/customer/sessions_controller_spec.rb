require 'rails_helper'

describe Customer::SessionsController do
  describe '#create' do
    let(:customer) { create(:customer, password: 'password')}

    example "「次回から自動でログインする」にチェックせずにログイン" do
      post :create, customer_login_form: {
          email: customer.email,
          password: 'password'
      }

      expect(session[:customer_id]).to eq(customer.id)
      expect(response.cookies).not_to have_key('customer_id')
    end
    example "「次回から自動でログインする」にチェックせずにログイン" do
      post :create, customer_login_form: {
          email: customer.email,
          password: 'password',
          remember_me: '1'
      }

      expect(session).not_to have_key(:customer_id)
      # response.cookiesの戻り値が文字列のため、'customer_id'と指定する
      # 末尾に40桁の16進数を持つ
      expect(response.cookies['customer_id']).to match(/[0-9a-f]{40}\z/)

      # cookiesにはこんな値が入っている　instance_variable_getメソッドで取得できる
      # {"customer_id"=>{:value=>"MzI=--dec0975890676878be918aafa0ad71c5e3ceca26",
      # :expires=>Sat, 13 Mar 2038 23:16:41 JST +09:00, :path=>"/"}}
      cookies = response.request.env['action_dispatch.cookies'].instance_variable_get(:@set_cookies)
      # cookieの有効期限が19年後であること
      expect(cookies['customer_id'][:expires]).to be > 19.years.from_now
    end
  end
end