json.extract! post, :id, :name, :email, :password_digest, :created_at, :updated_at
json.url post_url(post, format: :json)
