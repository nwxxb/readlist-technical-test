module ApplicationHelper
  def append_class_on_current_links(path, old_class, add:)
    if current_page?(path)
      "#{old_class} #{add}"
    else
      old_class
    end
  end
end
