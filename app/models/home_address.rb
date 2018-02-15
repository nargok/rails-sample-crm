class HomeAddress < Address
  validates :postal_code, :prefecture, :city, :address1, presence: true
  validates :company_code, :division_name, :absence: true
end
