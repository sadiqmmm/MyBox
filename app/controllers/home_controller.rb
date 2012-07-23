class HomeController < ApplicationController
  def index
    if user_signed_in?
      # load the current user's folders
      @folders = current_user.folders.roots
      
      # load the current user's files (assets)
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc") 
    end
  end
    
  def browse
    #get the folders owned/created by the current user
    @current_folder = current_user.folders.find(params[:folder_id])
      
    if @current_folder
      
      #getting the folders which are inside this @current_folder
      @folders = @current_folder.children
        
       #Only show files under the current folder
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")
        
      render :action => "index"
    else
        flash[:error] = "Don't be cheeky, mind your own folders!"
        redirect_to root_url
    end
  end
end
