module GroupsHelper
  def link_to_add_attachment(name, &block)
    html = capture(&block)
    link_to_function name, %{
      var text = '#{escape_javascript html}'.replace(/replace_it/g, new Date().getTime());
      $(text).appendTo('#attachments')
    }
  end
end
