ActiveAdmin.register Hotell do

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
  menu :parent => "Admin"
end
