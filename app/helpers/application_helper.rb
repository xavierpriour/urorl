module ApplicationHelper
  def nav_link(title, url)
    content_tag :li, {'class' => current_page?(url) ? 'active' : nil} do
      content_tag(:a, title, {
        'href' => url,
      })
    end
  end
end
