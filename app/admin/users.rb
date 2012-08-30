ActiveAdmin.register User do

  index do
    column :email
    column :role
    column :last_sign_in_at

    #default_actions :except => [:delete, :edit]
    column "" do |user|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(user), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(user), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end

  end

  form do |f|
    f.inputs "Users" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end

    f.buttons
  end

  filter :role
  
end
