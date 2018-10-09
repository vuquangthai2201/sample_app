module ApplicationHelper
    def full_title page_title
        base_title = I18n.t "helper.application_help.application_text1"
        page_title.blank? ? base_title : page_title + " | " + base_title
    end
end
