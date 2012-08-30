ActiveAdmin.register Role do

  menu :parent => "Users"

  index do
    column :name
    column "" do |role|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(role), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(role), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end

  config.clear_sidebar_sections!
  
end
