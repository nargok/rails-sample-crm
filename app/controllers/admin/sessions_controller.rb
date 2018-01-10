class Admin::SessionsController < Admin::Base
	skip_before_action :authorize

	def new
		if current_administrator
			redirect_to :admin_root
		else
			@form = Admin::LoginForm.new
			render action: :new
		end
	end

	def create
		@form = Admin::LoginForm.new(params[:admin_login_form])
		if @form.email.present?
			admin = Administrator.find_by(email_for_index: @form.email.downcase)
		end
		if admin.suspended == true
			flash.now[:alert] = 'アカウントが停止されています。'
			render action: :new
		elsif Admin::Authenticator.new(admin).authenticate(@form.password)
			session[:administrator_id] = admin.id
			session[:last_access_time] = Time.current
			flash.notice = 'ログインしました'
			redirect_to :admin_root
		else
			flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
			render action: :new
		end
	end

	def destroy
		session.delete(:administator_id)
		flash.notice = 'ログアウトしました'
		redirect_to :admin_root
	end
end
