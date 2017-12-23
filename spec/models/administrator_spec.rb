require 'rails_helper'

RSpec.describe Administrator, :type => :model do
	describe 'passward=' do
		example 'hashed_password is String & length is 60 with password' do
			admin = Administrator.new
			admin.password = 'foobar'
			expect(admin.hashed_password).to be_kind_of(String)
			expect(admin.hashed_password.size).to eq 60
		end

		example 'hashed_password is nil witout password' do
			admin = Administrator.new
			admin.hashed_password = 'x'
			admin.password = nil
			expect(admin.hashed_password).to be_nil
		end
	end
end
