test_rsa:
	ssh-keygen -t rsa -b 2048 -C 'test key' -N '' -f ~/.ssh/test_rsa

rsa_permission:
	chmod 400 ~/.ssh/test_rsa

ssh_connect:
	ssh -i ~/.ssh/test_rsa ec2-user@publicID

