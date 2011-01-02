module ActionDispatch::Routing
  #  # Ensure Devise modules are included only after loading routes, because we
  #  # need devise_for mappings already declared to create filters and helpers.
  #  def finalize_with_devise!
  #    finalize_without_devise!
  #    Devise.call_routes_prepare!
  #    Devise.configure_warden!
  #  end
  #  alias_method_chain :finalize!, :devise
  #end

  class Mapper
    def typus_routes
      scope "admin", :module => :admin, :as => "admin" do
        match "/" => "dashboard#show", :as => "dashboard"
        match "user_guide" => "base#user_guide"

        if Typus.authentication == :session
          resource :session, :only => [:new, :create, :destroy], :controller => :session
          resources :account, :only => [:new, :create, :show, :forgot_password] do
            collection { get :forgot_password }
          end
        end

        Typus.models.map { |i| i.to_resource }.each do |resource|
          match "#{resource}(/:action(/:id(.:format)))", :controller => resource
        end

        Typus.resources.map { |i| i.underscore }.each do |resource|
          match "#{resource}(/:action(/:id(.:format)))", :controller => resource
        end
      end 
    end
  end
end

