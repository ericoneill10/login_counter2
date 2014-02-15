require 'json'
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def welcome
  end

  def login
  		user = User.new
	  	request_params = request.request_parameters()
	  	response = user.login(request_params[:user],request_params[:password])
	  	ret_val = Hash.new
	  	if response >= 0
	  		ret_val[:errCode] = 1
	  		ret_val[:count] = response
	  		render :json => ret_val
	  		
	  	else
	  		ret_val[:errCode] = response
	  		render :json => ret_val
	  	end
  end

  def add
  		user = User.new
	  	request_params = request.request_parameters()
	  	response = user.add(request_params[:user],request_params[:password])
	  	ret_val = Hash.new
	  	if response >= 0
	  		ret_val[:errCode] = 1
	  		ret_val[:count] = response
	  		render :json => ret_val
	  		
	  	else
	  		ret_val[:errCode] = response
	  		render :json => ret_val
	  	end
  end

  def reset
		user = User.new
	    response= user.reset()
	    ret_val = Hash.new
	    ret_val[:errCode] = response
	    render :json => ret_val
	end

	def create
		if params[:commit] == "Login"
			@user = User.new(post_params)
	  		@user.save
	  		redirect_to @user
  		elsif params[:commit] == "Add User"
  			render text: params[:post].inspect
  		end

	end

	def show
  		@user = User.find(params[:id])
	end

	def unitTest
		#cmd = "rake spec"
		tests = JSON.parse("rspec --format j")
		test_summary = Hash.new
		fails = tests["summary"]["failure_count"]
		num_tests = tests["summary"]["example_count"]
		test_summary[:nrFailed] = fails
      	test_summary[:totalTests] = num_tests
      	test_summary[:output] = "rspec --format j"



	end

	private
	  def post_params
	    params.require(:post).permit(:user, :password, :count)
	  end


end
