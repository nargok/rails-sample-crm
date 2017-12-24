StaffMember.create!(
	email: 'sabro@example.com',
	family_name: '山田',
	given_name: '太郎',
	family_name_kana: 'ヤマダ',
	given_name_kana: 'タロウ',
	password: 'password',
	start_date: Date.today
)

StaffMember.create!(
	email: 'suspend@example.com',
	family_name: '山本',
	given_name: '三郎',
	family_name_kana: 'ヤマモト',
	given_name_kana: 'サブロウ',
	password: 'foobar',
	start_date: Date.yesterday,
	suspended: true
)