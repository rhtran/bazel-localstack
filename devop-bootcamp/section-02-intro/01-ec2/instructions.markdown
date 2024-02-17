# [Getting started](https://docs.localstack.cloud/user-guide/aws/elastic-compute-cloud/)

## Create a Key Pair

To create a key pair, you can use the CreateKeyPair API. Run the following command to create the key pair and pipe the output to a file named key.pem:
```shell
awslocal ec2 create-key-pair \
    --key-name my-key \
    --query 'KeyMaterial' \
    --output text | tee key.pem
```

You can assign necessary permissions to the key pair file using the following command:
```shell
chmod 400 key.pem
```

Alternatively, we can import an existing key pair, for example if you have an SSH public key in your home directory under ~/.ssh/id_rsa.pub:
```shell
awslocal ec2 import-key-pair --key-name my-key --public-key-material file://~/.ssh/id_rsa.pub
```

## Add rules to your security group
Currently, LocalStack only supports the default security group. You can add rules to the security group using the AuthorizeSecurityGroupIngress API. Run the following command to add a rule to allow inbound traffic on port 8000:

## Run an EC2 Instance

You can fetch the Security Group ID using the DescribeSecurityGroups API. Run the following command to fetch the Security Group ID:
```shell
awslocal ec2 describe-security-groups
```

To start your Python Web Server in your locally emulated EC2 instance, you can use the following user script by saving it to a file named user_script.sh:
```shell
#!/bin/bash -xeu

apt update
apt install python3 -y
python3 -m http.server 8000
```

You can now run an EC2 instance using the RunInstances API. Run the following command to run an EC2 instance by adding the appropriate Security Group ID that we fetched in the previous step:
```shell
awslocal ec2 run-instances \
    --image-id ami-ff0fea8310f3 \
    --count 1 \
    --instance-type t3.nano \
    --key-name my-key \
    --security-group-ids '<SECURITY_GROUP_ID>' \
    --user-data file://./user_script.sh
```