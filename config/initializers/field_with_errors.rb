ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.gsub(/class="(.*?)"/, 'class="\1 is-invalid"').html_safe
end
