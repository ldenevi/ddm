module TemplatesHelper
  def edit_field(field_data)
    if field_data.to_s.empty?
      "Enter text here"
    else
      field_data.html_safe
    end
  end
end
