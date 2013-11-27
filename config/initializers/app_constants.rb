#
# Centralized app configuration settings.
#
# This module encapsulates hashes with configuration keys => values
#
# Convention:
# Only the model should access its own AppSettings hash. 
# Everywhere else should use it from the model.
#   
#   # AppSettings.rb
#     MODEL = {
#       config: config_value
#     }
#
#   # Model.rb
#   class Model
#     CONFIG = AppSettings::MODEL[:config]
#     ...
#   end
#
#   # Anywhere else outside of the Model.rb 
#   # that needs to use the config (specs, controller, etc)
#     Model::CONFIG
#
module AppSettings

  QUERY = {
    default_search_radius: 5000 # in meters
  }

end
