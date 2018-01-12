class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      # 特定の職員のイベントを見る
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occured_at: :desc)
    else
      # 全職員のイベントを見る
      @events = StaffEvent.order(occured_at: :desc)
    end
  end
end
