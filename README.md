# cloudrun-functions
Test repo demonstrating how to use Cloud Build and Terraform to enable IaC on Cloud Run functions.

## Deploy

## Deploy with Cloud Functions v2 API
```
cd app
gcloud functions deploy python-http-function \
    --gen2 \
    --runtime=python312 \
    --region=us-central1 \
    --source=. \
    --entry-point=hello_http \
    --trigger-http \
    --allow-unauthenticated
```

## Deploy with Run functions
```
cd app
 gcloud beta run deploy python-http-function \
    --source=. \
    --function=hello_http \
    --base-image=python312 \
    --region=us-central1 \
    --allow-unauthenticated
```

## Build with Cloud Build & Terraform
1. Create an AR repo `public-app` in your desired region

1. In infra/func create a `terraform.tfvars` file with the following variables:

```
project_id = "GCP Project ID"
function_files = {
    "../../app/main.py" = "path-to-function", # change if necessary
    "../../app/requirements.txt"  = "app/requirements.txt" # change if necessary
}

bucket_id = "GCS bucket ID"
bucket_location = "GCS bucket location"

function_name = "your function name"
function_location = "Run location"
function_entrypoint = "hello-HTTP"

```

2. move back to the root directory and run a build

```
gcloud builds submit --config ./infra/function/cloudbuild.yaml --region northamerica-northeast2
```

## Configuring a Build Trigger
You may want to make it so that the function builds whenever a notable git event happens. In
this example we will make a Cloud Build repository conenction and trigger to build the function
everytime a commit is made to `main`. Note that you'll only neeed to do this one time to set up
the trigger.

1. Move into the `infra/ci-function` repo

```
cd infra/ci-function
```

1. Create a `terraform.tfvars` file with the following:

```
project_id = "GCP project ID"
project_location = "GCP project location"
secret_id = "ID given to the GitHub personal access token stored stored in Secret Manager"
secret_sa = "Secret Manger Service Account"
build_connector_name = "Name for the Github Connector"
build_trigger_name = "Name given to the Build Trigger"
build_config_path = "Path to the cloudbuild config file"
github_pat = "GitHub personal access token (classic only)"
github_app_installation_id = "Github Cloud Build application installation ID"
github_repo_name= "Name of your GitHub repo, no spaces"
github_repo_uri= "URL to your GitHub repo, HTTPS"
github_branch = "branch to monitor
```

1. TODO: upload the TFvars for your application (not the trigger) into GCS

1. Iinitialize your Terraform

```
tf init
```

1. Generate the plan
```
tf plan
```

1. If that looks good, apply it
```
tf apply
```

TODO: this won't work yet, need to update the terraform to read vars from GCS bucket 