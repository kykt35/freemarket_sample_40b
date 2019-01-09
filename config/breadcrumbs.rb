crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_path
  parent :root
end

crumb :identification do
  link "本人情報", mypage_identification_path
  parent :mypage
end

crumb :card do
  link "支払い方法", credits_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", mypage_profile_path
  parent :mypage
end

crumb :logout do
  link "ログアウト",  users_logout_path
  parent :mypage
end

crumb :sales_amounts do
  link "売上・振込申請", sales_amounts_path
  parent :mypage
end

crumb :favorite do
  link "いいね！一覧",  mypage_favorite_path
  parent :mypage
end

crumb :categories do
  link "カテゴリ一覧",  categories_path
  parent :root
end

crumb :category do |category|
  link category.name, category_path(category)
  if category.parent
    parent category.parent
  else
    parent :categories
  end
end

crumb :search do |keyword|
  link keyword, items_seach_path(q: keyword)
  parent :root
end

crumb :item do |item|
  link item.name, item_path(item)
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
