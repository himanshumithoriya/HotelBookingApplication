ActiveAdmin.register Hotell do
  menu label: "My Hotels"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :contact, :status, :location_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :contact, :status, :location_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    column :name
    column :address
    column :contact
    column :status
    column :location_id
    column :user_id
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :contact
      row :status
      row :location_id
      row :user_id
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :contact
      f.input :status
      f.input :location_id
      f.input :user_id
    end
    f.actions
  end

  # filter :by_date_completed, label: 'By Date Completed', as: :date_range

  # collection_action :import_csv, method: :post do
  #   redirect_to collection_path, notice: "CSV imported successfully!"
  # end
  
# index do
#   id_column
#   column :name
#   actions
# end

# index as: :grid do |hotell|
#   link_to name_tag(hotell.name_path), admin_hotell_path(hotell)
# end

  filter :name

  config.per_page = 3 

  controller do
    before_action only: :index do
      @per_page = 5
  end
end
  
  # config.paginate = false


end
