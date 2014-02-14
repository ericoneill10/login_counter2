class User < ActiveRecord::Base
	#validates :user, :presence => true, :uniqueness => {case_sensitive: false}, :length => { maximum: 128 }
	#validates :password, :presence => true

	SUCCESS = 1

	ERR_BAD_CREDENTIALS   =  -1

	ERR_USER_EXISTS       =  -2

	ERR_BAD_USERNAME      =  -3

	ERR_BAD_PASSWORD      =  -4

	MAX_USERNAME_LENGTH = 128

	MAX_PASSWORD_LENGTH = 128

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
		if not valid_username(user)
			return ERR_BAD_USERNAME
		end
		if not valid_password(password)
			return ERR_BAD_PASSWORD
		end
		user_add = User.new(user: user, password: password, count: 1)
		user_add.save
		return user_add.count
		


	end


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

	def reset()
		ActiveRecord::Migration.drop_table(:users)
		return 1
	end
end
