class User < ActiveRecord::Base
	

	SUCCESS = 1

	ERR_BAD_CREDENTIALS   =  -1

	ERR_USER_EXISTS       =  -2

	ERR_BAD_USERNAME      =  -3

	ERR_BAD_PASSWORD      =  -4

	MAX_USERNAME_LENGTH = 128

	MAX_PASSWORD_LENGTH = 128

	validates :user, :presence => true, :uniqueness => {case_sensitive: false}, :length => { maximum: MAX_USERNAME_LENGTH }
	validates :password, :presence => true, :length => { maximum: MAX_PASSWORD_LENGTH}

	def login(user, password)
		usr_query = User.find_by user: user.downcase
		if usr_query.nil?
			return ERR_BAD_CREDENTIALS
		end
		if usr_query.password != password
			return ERR_BAD_CREDENTIALS
		end
		usr_query.count +=1
		usr_query.save
		return usr_query.count
	end

	def add(user, password)
		user_query = User.find_by user: user.downcase
		if not user_query.nil?
			return ERR_USER_EXISTS
		end
		/
		if not valid_username(user)
			return ERR_BAD_USERNAME
		end
		if not valid_password(password)
			return ERR_BAD_PASSWORD
		end
		/
		user_add = User.new(user: user, password: password, count: 1)
		if not user_add.valid?
			if user_add.errors.added? :user, :too_long, :count => MAX_USERNAME_LENGTH or user_add.errors.added? :user, :blank
				return ERR_BAD_USERNAME
			elsif user_add.errors.added? :password, :too_long, :count => MAX_PASSWORD_LENGTH
				return ERR_BAD_PASSWORD
			end
		end

		
		user_add.save
		return user_add.count
		


	end

	/ UNNESSECARRY WITH VALIDATIONS
	def valid_username(username)
		# I don't know why I needed to do it like this, but doing it in one line
		# made it fail
		val1= username != ""
		val2 =  username.length <= MAX_USERNAME_LENGTH
		val3 =val1 and val2
		return val3
	end

	def valid_password(password)
		return password.length <= MAX_PASSWORD_LENGTH
	end
/
	def reset()
		connection = ActiveRecord::Base.connection
    	ActiveRecord::Base.connection.execute("DELETE FROM users")
		return 1
	end
end
