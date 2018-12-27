echo "Create the initial CloudFormation Stack"
aws --profile <YOUR_PROFILE> cloudformation create-stack --stack-name "AdministerPipeline<PROJECT_NAME_CAMEL>" --template-body file://aws_seed.yml --parameters file://aws_seed-cli-parameters.json --capabilities "CAPABILITY_NAMED_IAM"
echo "Waiting for the CloudFormation stack to finish being created."
aws --profile <YOUR_PROFILE> cloudformation wait stack-create-complete --stack-name "AdministerPipeline<PROJECT_NAME_CAMEL>"
# Print out all the CloudFormation outputs.
aws --profile <YOUR_PROFILE> cloudformation describe-stacks --stack-name "AdministerPipeline<PROJECT_NAME_CAMEL>" --output table --query "Stacks[0].Outputs"

export CODECOMMIT_REPO=`aws --profile <YOUR_PROFILE> cloudformation describe-stacks --stack-name "AdministerPipeline<PROJECT_NAME_CAMEL>" --output text --query "Stacks[0].Outputs[?OutputKey=='CodeCommitRepositoryCloneUrlHttp'].OutputValue"`

echo "You can push your repo to: "
echo $CODECOMMIT_REPO
echo ""
echo "You can set the origin to push do by copying the following line: "
git remote add origin $CODECOMMIT_REPO
echo "Finished."
