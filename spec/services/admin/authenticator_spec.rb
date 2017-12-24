require 'rails_helper'

RSpec.describe Admin::Authenticator do
	describe '#authenticate' do
		before(:each) do
			@admin = build(:administrator)
		end

		example '正しいパスワードならtrueを返す' do
			expect(Admin::Authenticator.new(@admin).authenticate('pw')).to be_truthy
		end

		example '誤ったパスワードならfalseを返す' do
			expect(Admin::Authenticator.new(@admin).authenticate('cd')).to be_falsey
		end

		example 'パスワード未設定ならfalseを返す' do
			expect(Admin::Authenticator.new(@admin).authenticate(nil)).to be_falsey
		end

		example '停止フラグがたっていればfalseを返す' do
			@admin.suspended = true
			expect(Admin::Authenticator.new(@admin).authenticate('pw')).to be_falsey
		end

	end
end