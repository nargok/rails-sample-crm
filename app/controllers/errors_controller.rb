class ErrorsController < ApplicationController
	def not_found
		# raise 例外を発生させるメソッド
		raise ActionController::RoutingError,  # 第1引数：例外クラス
			"No route muches #{request.path.inspect}" # 第2引数：メッセージ
	end
end
