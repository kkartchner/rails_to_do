class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource) 
    # This makes it so the user is redirected to the to_dos_path instead
    # of to the root path
    stored_location_for(resource) || to_dos_path 
  end

  def is_number? (string)
    return true if Float(string) rescue false
  end
end
