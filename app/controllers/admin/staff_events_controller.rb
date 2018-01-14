class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      # 特定の職員のイベントを見る
      @staff_member = StaffMember.find(params[:staff_member_id])
      # ActiveRecord::Relationクラスのインスタンスを取得する
      # この時点ではまだクエリは発行されない。クエリのための検索条件を指定しているだけ
      @events = @staff_member.events
    else
      # 全職員のイベントを見る
      @events = StaffEvent
    end
    # クエリ発行のための検索条件を追加している
      @events = @events.order(occured_at: :desc).includes(:member).page(params[:page])
    end
end
