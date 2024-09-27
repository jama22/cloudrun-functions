# cloudrun-functions
testing cloud run functions

## Deploy

### Deploy with Cloud Functions v2 API
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

### Deploy with Run functions
```
cd app
 gcloud beta run deploy python-http-function \
    --source=. \
    --function=hello_http \
    --base-image=python312 \
    --region=us-central1 \
    --allow-unauthenticated
```

### Build with Cloud Build & Terraform
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
