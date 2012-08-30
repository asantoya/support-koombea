ActiveAdmin.register AdminUser do

  index do
    column :email
    column :last_sign_in_at

    column "" do |admin_user|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(admin_user), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(admin_user), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end

  form do |f|
    f.inputs "AdminUser" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end

  config.clear_sidebar_sections!

end
