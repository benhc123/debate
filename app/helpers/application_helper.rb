module ApplicationHelper
  def markdown_to_html(markdown_text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdown.render(markdown_text)
  end
end
