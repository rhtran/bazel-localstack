S3
Create a bucket

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 mb s3://mytestbucket
make_bucket: mytestbucket

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 ls
2006-02-03 08:45:09 mytestbucket
Copy a file over

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 cp /tmp/mongo.log s3://mytestbucket
upload: ../../../../tmp/mongo.log to s3://mytestbucket/mongo.log

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 ls s3://mytestbucket
2017-04-05 01:18:39       4789 mongo.log
Delete this file

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 rm s3://mytestbucket/mongo.log
delete: s3://mytestbucket/mongo.log

bash-3.2$ aws --endpoint-url=http://localhost:4572 s3 ls s3://mytestbucket

bash-3.2$
SNS
Create a topic

bash-3.2$ aws --endpoint-url=http://localhost:4575 sns list-topics
{
"Topics": []
}

bash-3.2$ aws --endpoint-url=http://localhost:4575 sns create-topic --name test-topic
{
"TopicArn": "arn:aws:sns:us-east-1:123456789012:test-topic"
}
bash-3.2$ aws --endpoint-url=http://localhost:4575 sns list-topics
{
"Topics": [
{
"TopicArn": "arn:aws:sns:us-east-1:123456789012:test-topic"
}
]
}

Subscribe to the topic

(use any random email)

bash-3.2$ aws --endpoint-url=http://localhost:4575 sns subscribe --topic-arn arn:aws:sns:us-east-1:123456789012:test-topic --protocol email --notification-endpoint pibehatin@1rentcar.top
{
"SubscriptionArn": "arn:aws:sns:us-east-1:123456789012:test-topic:5aacffbe-ccf7-40d5-be97-c55af7392935"
}

bash-3.2$ aws --endpoint-url=http://localhost:4575 sns list-subscriptions
{
"Subscriptions": [
{
"Owner": "",
"Endpoint": "pibehatin@1rentcar.top",
"Protocol": "email",
"TopicArn": "arn:aws:sns:us-east-1:123456789012:test-topic",
"SubscriptionArn": "arn:aws:sns:us-east-1:123456789012:test-topic:5aacffbe-ccf7-40d5-be97-c55af7392935"
}
]
}

Publish to this topic

bash-3.2$ aws --endpoint-url=http://localhost:4575 sns publish  --topic-arn arn:aws:sns:us-east-1:123456789012:test-topic --message 'Test Message!'
{
"MessageId": "n/a"
}
SQS
Create a Queue

bash-3.2$ aws --endpoint-url=http://localhost:4576 sqs create-queue --queue-name test_queue
{
"QueueUrl": "http://localhost:4576/123456789012/test_queue"
}

bash-3.2$ aws --endpoint-url=http://localhost:4576 sqs list-queues
{
"QueueUrls": [
"http://localhost:4576/123456789012/test_queue"
]
}
Send a message to this queue

bash-3.2$  aws --endpoint-url=http://localhost:4576 sqs send-message --queue-url http://localhost:4576/123456789012/test_queue --message-body 'Test Message!'
{
"MD5OfMessageBody": "df69267381a60e476252c989db9ac8ad",
"MessageId": "a6ed436b-076a-0d8d-73e1-cc3291a19c28"
}

Receive the message from this queue

bash-3.2$  aws --endpoint-url=http://localhost:4576 sqs receive-message --queue-url http://localhost:4576/123456789012/test_queue
{
"Messages": [
{
"Body": "Test Message!",
"Attributes": {
"ApproximateFirstReceiveTimestamp": "1.49138149959e+12",
"SenderId": "AIDAIT2UOQQY3AUEKVGXU",
"ApproximateReceiveCount": "1",
"SentTimestamp": "1.49138142195e+12"
},
"ReceiptHandle": "xuazrzyjcgpgzpzlxlyxmujbgzfkswixjkywshturlylrfwzyccutlumitgduyzddwkaoypcmswlkxrrjghdyztfewrpmkxdufptyketrfumwzicmggogdbaucwztvorplibccpfhirmalnixvfbklzrgncpisdsiuiajqwefxueqhuygfibmgqwx",
"MD5OfBody": "df69267381a60e476252c989db9ac8ad",
"MessageId": "a6ed436b-076a-0d8d-73e1-cc3291a19c28"
}
]
}
If you do this many times, the process seems to sleep. May be to simulate the message visibility? Here are 2 consecutive runs.

real	0m15.185s
user	0m0.291s
sys	0m0.158s
real	0m26.829s
user	0m0.291s
sys	0m0.167s
I have reported this issue here - https://github.com/atlassian/localstack/issues/52

Delete this message

bash-3.2$ aws --endpoint-url=http://localhost:4576 sqs delete-message --queue-url http://localhost:4576/123456789012/test_queue --receipt-handle 'yugzzebhnnksfuvbjlibfnlejyqbulxqfegsnrgafjeabxaatxbmeiyfkfliedslohseosgjwkxhdzllpudhccjhorpkwbgjgyzeyzjwkfvqflathnvsmugeyevbqmfyqanuxetvdhcetseuwzrqpexogzggznndxmbqowtlalvqtffntdahhihel'

DynamoDB
Create a table

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb create-table --table-name test_table  --attribute-definitions AttributeName=first,AttributeType=S AttributeName=second,AttributeType=N --key-schema AttributeName=first,KeyType=HASH AttributeName=second,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
{
"TableDescription": {
"TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/test_table",
"AttributeDefinitions": [
{
"AttributeName": "first",
"AttributeType": "S"
},
{
"AttributeName": "second",
"AttributeType": "N"
}
],
"ProvisionedThroughput": {
"NumberOfDecreasesToday": 0,
"WriteCapacityUnits": 5,
"ReadCapacityUnits": 5
},
"TableSizeBytes": 0,
"TableName": "test_table",
"TableStatus": "CREATING",
"KeySchema": [
{
"KeyType": "HASH",
"AttributeName": "first"
},
{
"KeyType": "RANGE",
"AttributeName": "second"
}
],
"ItemCount": 0,
"CreationDateTime": 1491818083.66
}
}

We can verify our created table -

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb list-tables
{
"TableNames": [
"test_table"
]
}
and describe it too

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb describe-table --table-name test_table
{
"Table": {
"TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/test_table",
"AttributeDefinitions": [
{
"AttributeName": "first",
"AttributeType": "S"
},
{
"AttributeName": "second",
"AttributeType": "N"
}
],
"ProvisionedThroughput": {
"NumberOfDecreasesToday": 0,
"WriteCapacityUnits": 5,
"ReadCapacityUnits": 5
},
"TableSizeBytes": 0,
"TableName": "test_table",
"TableStatus": "ACTIVE",
"KeySchema": [
{
"KeyType": "HASH",
"AttributeName": "first"
},
{
"KeyType": "RANGE",
"AttributeName": "second"
}
],
"ItemCount": 0,
"CreationDateTime": 1491818083.66
}
}
Put item

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb put-item --table-name test_table  --item '{"first":{"S":"Jack"},"second":{"N":"42"}}'

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb put-item --table-name test_table  --item '{"first":{"S":"Manish"},"second":{"N":"40"}}'
Scan Table

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb scan --table-name test_table

{
"Count": 2,
"Items": [
{
"second": {
"N": "40"
},
"first": {
"S": "Manish"
}
},
{
"second": {
"N": "42"
},
"first": {
"S": "Jack"
}
}
],
"ScannedCount": 2,
"ConsumedCapacity": null
}

Get item


bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb get-item --table-name test_table  --key '{"first":{"S":"Manish"},"second":{"N":"40"}}'

{
"Item": {
"second": {
"N": "40"
},
"first": {
"S": "Manish"
}
}
}
Query

I hate to query over CLI, and you can see why. Hope this can help you realize that the best way to deal with DynamoDB is via an SDK.

bash-3.2$ aws --endpoint-url=http://localhost:4569 dynamodb query --table-name test_table --projection-expression "#first, #second" --key-condition-expression "#first = :value" --expression-attribute-values '{":value" : {"S":"Manish"}}' --expression-attribute-names '{"#first":"first", "#second":"second"}'
{
"Count": 1,
"Items": [
{
"second": {
"N": "40"
},
"first": {
"S": "Manish"
}
}
],
"ScannedCount": 1,
"ConsumedCapacity": null
}
