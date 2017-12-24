FactoryGirl.define do
	factory :staff_member do
		sequence(:email) { |n| "member#{n}@example.com"}
		family_name '山田'
		given_name '太郎'
		family_name_kana 'ヤマダ'
		given_name_kana 'タロウ'
		password 'pw'
		start_date { Date.yesterday }
		# TODO 後でend_dateに修正する
		end_data nil
		suspended false
	end
end