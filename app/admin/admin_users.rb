ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :password
    column :password_confirmation
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  ActiveAdmin.setup do |config|
    config.namespace :admin do |admin|
      admin.build_menu :utility_navigation do |menu|
        menu.add label: "ActiveAdmin.info", url: "https://www.activeadmin.info",
                                            html_options: { target: :blank }
        admin.add_current_user_to_menu  menu
        admin.add_logout_button_to_menu menu
      end
    end
  end

  # config.namespace :admin do |admin|
  #   admin.build_menu do |menu|
  #     menu.add label: "The Application", url: "/", priority: 0

  #     menu.add label: "Sites" do |sites|
  #       sites.add label: "Google",
  #                 url: "https://google.com",
  #                 html_options: { target: :blank }

  #       sites.add label: "Facebook",
  #                 url: "https://facebook.com"

  #       sites.add label: "Github",
  #                 url: "https://github.com"
  #     end
  #   end
  # end



end
