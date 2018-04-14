ActiveAdmin.register Professor do
  permit_params :first_name, :last_name, subject_ids: []

  show do
    attributes_table do
      row :first_name
      row :last_name
    end

    panel 'Subjects' do
      if professor.subjects.any?
        table_for professor.subjects do
          column :code
        end
      else
        content_tag :div do
          "No subjects for this professor.".html_safe + " " +
          link_to("Add subject", edit_admin_professor_path)
        end
      end
    end

  end

  form do |f|
    f.semantic_errors
    f.inputs do
      input :first_name
      input :last_name
      input :subject_ids, as: :selected_list, fields: [:code], display_name: :code, label: 'Subjects'
    end

    f.actions
  end
end
