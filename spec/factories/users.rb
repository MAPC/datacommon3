FactoryGirl.define do
  factory :user do
    username   "username"
    first_name "First"
    last_name  "Last"
    email      "first@last.io"
    password   "pa55word"
    is_staff     false
    is_active    true
    is_superuser false
  end

  factory :staff, class: User do
    username   "staff"
    first_name "Staff"
    last_name  "Member"
    email      "staff@mapc.org"
    password   "pa55Word"
    is_staff     true
    is_active    true
    is_superuser false
  end

  factory :admin, class: User do
    username   "admin"
    first_name "Admin"
    last_name  "Istrator"
    email      "admin@mapc.org"
    password   "pa55W0rd"
    is_staff     true
    is_active    true
    is_superuser true
  end

  factory :inactive_user, class: User do
    username   "inactive"
    first_name "In"
    last_name  "Active"
    email      "inactive@email.net"
    password   "passw0rd"
    is_staff     false
    is_active    false
    is_superuser false
  end
end
