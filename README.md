# wercker-step-deploy-to-ecs
Step for deploying to ECS using Wercker.

Similar to the step `aws-ecs`, but it doesn't downscale the old service first and it takes a path to a JSON template for the task definition.

Currently, the step requires the AWS CLI to be installed in the 'box' it runs on.

# Parameters
| Name              | Description   |
| ----------------- | ------------- |
| aws_key           | The access key ID for an IAM user that can register tasks and update services for ECS. |
| aws_secret        | The secret for the above user. |
| aws_region        | The AWS region to operate in. |
| template_file     | Full path to the task definition JSON template file. |
| cluster           | The name of the ECS cluster. |
| service           | The name of the ECS service. |
| task              | The name (family) of the ECS task definition. |
| revisions         | The number of revisions of task definition to keep (default: 5, 0 or negative number = infinite). |

If you don't provide a cluster and/or service, only the task is updated, not the service.

# Example usage

```
deploy-to-ecs:
  box: garland/aws-cli-docker
  steps:
    - slijkhuis/deploy-to-ecs:
        aws_key: $AWS_ECS_KEY
        aws_secret: $AWS_ECS_SECRET
        aws_region: $AWS_REGION
        template_file: "$WERCKER_SOURCE_DIR/task-definition.json.template"
        cluster: "YourCluster"
        service: "YourService"
        task: "YourTaskDefinition"
```
