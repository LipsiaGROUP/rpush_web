RpushWeb.setup do |config|
  # RpushWeb will call this within DevicesController to ensure the user is authenticated.
  # config.authentication_method = :authenticate_user!

  # RpushWeb will call this within DevicesController to return the current logged in user.
  # config.current_user_method = :current_user
end
