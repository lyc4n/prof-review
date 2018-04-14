ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    column :id
    column :fullname do |user|
      user.full_name
    end

    actions
  end

  show do
    attributes_table do
      row :fullname do |user|
        user.full_name
      end
      row :email
      row :created_at
      row :updated_at
    end
  end

  controller do
    def update_resource(object, attributes)
      attributes.each do |attr|
        if attr[:password].blank? and attr[:password_confirmation].blank?
          attr.delete :password
          attr.delete :password_confirmation
        end
      end

      object.send :update_attributes, *attributes
    end
  end
end
