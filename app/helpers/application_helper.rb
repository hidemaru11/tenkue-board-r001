module ApplicationHelper

  # 日時の表示を設定
  def default_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def comments_presence?(comments)
    comments if 0 < comments
  end
end
