json.extract! invitation, :id, :user_id, :group_id, :accepted, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
