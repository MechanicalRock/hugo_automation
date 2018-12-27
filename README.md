# Hugo website hosting and build automation with AWS

This repo includes a bunch of cloudformation and scripts which help you get setup quickly with your
[Hugo](https://gohugo.io) website.

It will:
1. Run an initialisation script which creates the necessary resources to run the infrastructure.
   - Create a code pipeline
   - Create an S3 bucket for pipeline artifacts
   - Create a bunch of roles required to execute these functions.
   - Create a code commit repo on AWS.
1. Execute a run of the pipeline on first push to the repo which adds in required resources which
   are made after creation.

## How to use these files.

1. Either clone or copy the files down to the root directory of your Hugo website installation.
1. Install and setup the AWS CLI, and set your profile (note the profile down).
1. Do a find and replace for <YOUR_PROFILE> and replace with the profile name from the previous
   step.

    For example, one of the steps in the script executes a cloudformation command, and uses your AWS
    profile that you've set. If my profile was joebloggs, then this:
    > aws --profile <YOUR_PROFILE> cloudformation create-stack

    will become:
    > aws --profile joebloggs cloudformation create-stack
2. Decide on a name for your project. And create two naming conventions. For example:
      - MyCoolProject (for camel-case)
      - my-cool-project (for dashes)
3. Similar to step 3 do a find and replace in this project for <PROJECT_NAME_CAMEL> with the camel
   case naming scheme and <PROJECT_NAME_DASHES> with the dashed naming convention.

    For example:
    > "WebsiteBucketName": "<PROJECT_NAME_DASHES>"

    Will become:
    > "WebsiteBucketName": "my-cool-project"

## On the TODO list
- Add Route53
- Add CloudFront

## Some caveats/gotchas
- AWS only allows a single bucket name to exist in the world, not per account. So you need to choose
  a bucket name that's not taken. A quick check in the console to see if you can create the bucket
  should be fine. Note that you shouldn't actually create the bucket as you'll then need to wait for
  the deletion to propagate through AWS afterwards. At time of writing you can get to the naming
  stage of your bucket in the console to see if it's available.
