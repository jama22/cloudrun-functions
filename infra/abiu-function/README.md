# Deploying a function using Cloud Run's Automatic Base Image Updates

## Build your function /service
Unlike the GCF v2 Terraform module, the Run terraform will not help you run
a build job on your behalf. A few things to consider:

* Identify the most convenient way to build a container and push it to
Artifact Registry (e.g. locally, Cloud Build, GitHub Actions)
* Read the Cloud Run documentation on automatic base image updates
to understand how this works, and know that you'll need to deploy
this onto a `scratch` image

For simplicity, I chose to use the Cloud Native Buildpacks [`pack` CLI] (https://github.com/buildpacks/pack) to do this

```
pack build my-function \
    --builder=us-central1-docker.pkg.dev/serverless-runtimes/google-22-full/builder/python:public-image-current \
    --run-image=us-central1-docker.pkg.dev/serverless-runtimes/google-22/scratch/python312 \
```

This creates an image built on the scratch images published by GCP

Next, push it to Artifact Registry

```
docker tag my-function <YOUR AR REPO>/my-function
docker push <YOUR AR REPO/my-function
```

## Where to find information about base images
You can find all the supported runtimes in the [Cloud Run functions Runtime Support](https://cloud.google.com/functions/docs/runtime-support) page

## Setting up the Terraform
You'll need to create a `terraform.tfvars` file with the following variables:

```
project_id = "PROJECT_NAME"

function_name = "my-function"
function_location = "REGION"
function_target = "hello"
function_image = "FUNCTION_IMAGE"

base_image = "us-central1-docker.pkg.dev/serverless-runtimes/google-22/runtimes/python312"
```

Feel free to replace the base_image with whatever language you end up using. Note that you must use the fully qualified URL of the base image, and NOT the alias