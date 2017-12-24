Administrator.create!(
	email: 'hanako@example.com',
	password: 'foobar'
)

Administrator.create!(
	email: 'suspend_admin@example.com',
	password: 'foobar',
	suspended: true
)