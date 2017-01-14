module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - BaukisKai"
    else
      'BaukisKai'
    end
  end
end
