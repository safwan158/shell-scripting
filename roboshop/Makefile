help:
	@fgrep -h "##"  $(MAKEFILE_LIST) | grep -v fgrep 
	
catalogue:	## Installing Catalogue
	@bash components/catalogue.sh
	
mongodb:	## Installing MongoDB
	@bash components/mongodb.sh
	
redis:   	## Installing Redis
	@bash components/redis.sh

user:		## Installing User
	@bash components/user.sh
	
cart:		## Installing Cart
	@bash components/cart.sh
	
mysql:		## Installing MySql
	@bash components/mysql.sh
	
shipping:	## Installing Shipping
	@bash components/shipping.sh
	
rabbitmq:	## Installing RabbitMQ
	@bash components/rabbitmq.sh
	
payment:	## Installing Payment
	@bash components/payment.sh
	
frontend:	## Installing FrontEnd
	@bash components/frontend.sh