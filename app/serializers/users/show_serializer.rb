class Users::ShowSerializer < UserSerializer
  attributes :authentication_token, :last_sign_in_at, :provider, :uid,
              :created_at, :updated_at, :date_of_birth, :gender, :mobile_number
end