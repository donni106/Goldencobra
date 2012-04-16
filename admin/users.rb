ActiveAdmin.register User, :as => "User" do
  menu :parent => "Einstellungen", :label => "Benutzerverwaltung", :if => proc{can?(:update, User)}
  controller.authorize_resource :class => User
  
  filter :firstname
  filter :lastname
  filter :email
  actions :all, :except => [:new]

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Allgemein" do
      f.input :title
      f.input :firstname
      f.input :lastname
      f.input :email
      if current_user.has_role?('admin')
        f.input :roles, :as => :check_boxes, :collection => Goldencobra::Role.all
      end
      f.input :function
      f.input :phone
      f.input :fax
      f.input :facebook
      f.input :twitter
      f.input :linkedin
      f.input :xing
      f.input :googleplus
    end
    f.inputs "" do
      f.actions 
    end
  end
 

  index do
    selectable_column
    column :firstname
    column :lastname
    column :email
    column "Roles" do |u|
      u.roles.map{|r| r.name.capitalize}.join(", ")
    end
    default_actions
  end

  show :title => :lastname do
    panel "User" do
      attributes_table_for user do
        [:firstname, :lastname, :title, :email, :gender, :function, :phone, :fax, :facebook, :twitter, :linkedin, :xing, :googleplus, :created_at, :updated_at].each do |aa|
          row aa
        end
      end
    end #end panel applicant
  end
end