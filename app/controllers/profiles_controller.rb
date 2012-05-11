class ProfilesController < ApplicationController
	before_filter :authenticate_user
	
	def show
		@profile = Profile.find_by_user_id User.find_by_username params[:username]	
		if @profile
			#render "show"

			respond_to do |format|
				format.html
				format.json { render :json => @profile, :status => 200 }
			end

		else
			render text: "this page dose not exist"
		end
	end

	def index

	end

	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.create(params[:profile])
		@profile.user = @current_user
		# colleting tag
		tags = params[:tags].split(' ')

		tags.each do |tag|
			unless Tag.find_by_text tag
				new_tag = Tag.create :text => tag
				@profile.tags << new_tag
			else
				exist_tag = Tag.find_by_text tag
				@profile.tags << exist_tag unless @profile.tags.include? exist_tag
			end	
		end

		if @profile.save
			Person.create :profile_link => "/#{@current_user.username}", :user_id => @current_user.id
			@mydefaultaspect= Aspect.new :name => "MyAspects"
			@mydefaultaspect.user= @current_user
			@mydefaultaspect.save
			redirect_to home_path	
			
		else

			render 'new'
		end

	end

	def edit

		@profile = Profile.find_by_user_id @current_user.id

		@tags = []
		@profile.tags.each do |tag|
			@tags << tag.text
		end
		
	end
	
	def update
		@profile = Profile.find_by_user_id @current_user.id
		@profile.update_attributes(params[:profile])

		@current_user.update_attributes(:email =>params[:email])

		tags = params[:tags].split(' ')
		
		# add new tags
		tags.each do |tag|
			unless Tag.find_by_text tag
				new_tag = Tag.create :text => tag
				@profile.tags << new_tag
			else
				exist_tag = Tag.find_by_text tag
				@profile.tags << exist_tag unless @profile.tags.include? exist_tag
			end	
		end

		# remove old tag
		@profile.tags.each do |tag|
			unless tags.include? tag.text
				@profile.tags.delete tag
			end
		end

		@tags = []
		@profile.tags.each do |tag|
			@tags << tag.text
		end
		
		# change email
		@current_user.email = params[:email]

		if @profile.save && @current_user.save
			
			flash[:notice] = "Your changes have been saved"

			redirect_to("/#{@current_user.username}")	
		else

			render 'edit'
		end

	end

	def account_setting
		
	end

	def privacy_setting
		
	end

	def save
		#render text: params.to_json
		if params[:setting] == "account"
			render text: "acc"
		else	
			render text: "pri"
		end
	end
end
