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

  # ActiveAdmin.setup do |config|
  #   config.namespace :admin do |admin|
  #     admin.build_menu :utility_navigation do |menu|
  #       menu.add label: "ActiveAdmin.info", url: "https://www.activeadmin.info",
  #                                           html_options: { target: :blank }
  #       admin.add_current_user_to_menu  menu
  #       admin.add_logout_button_to_menu menu
  #     end
  #   end
  # end

  # action_item :view_pdf, only: :show do
  #   link_to 'View PDF', view_pdf_admin_product_path(resource), target: '_blank'
  # end
  # member_action :view_pdf, method: :get do
  #   @product = Product.find(params[:id])
  #   respond_to do |format|
  #     format.pdf do
  #       render pdf: "product_pdf",
  #              template: "admin/products/view_pdf.pdf.erb", # Path to your custom PDF template
  #              layout: 'pdf.html.erb', # Optional, specify your PDF layout
  #              show_as_html: params.key?('debug') # For testing, set 'debug' parameter in the URL to true to see HTML output
  #     end
  #   end
  # end

# byebug
#   link_to(
#     'Download Membership Form',
#     download_pdf_admin_users_path(id: object.id, format: :pdf)
#   )

  
end
