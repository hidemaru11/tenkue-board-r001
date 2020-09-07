crumb :root do
  link '投稿一覧'.html_safe, root_path
end

crumb :post_new do
  link "新規投稿"
end

crumb :post_show do |post|
  link "#{post.user.name}さんの投稿(#{post.id})"
end
