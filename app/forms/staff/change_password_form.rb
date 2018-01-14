class Staff::ChangePasswordForm
  include ActiveModel::Model # 非Active Recordモデルにする

  attr_accessor :object, :current_password, :new_password,
   :new_password_confirmation

  def save
    object.password = new_password
    object.save!
  end
end
