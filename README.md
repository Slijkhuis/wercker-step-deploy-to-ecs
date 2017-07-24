# wercker-step-deploy-to-ecs
Step for deploying to ECS using Wercker.

Similar to the step `aws-ecs`, but it doesn't downscale the old service first and it takes a path to a JSON template for the task definition.

Currently, the step requires the AWS CLI to be installed in the 'box' it runs on.
