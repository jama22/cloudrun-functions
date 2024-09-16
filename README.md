# cloudrun-functions
testing cloud run functions

## Deploy

### Deploy with functions
```
 gcloud functions deploy python-http-function \
    --gen2 \
    --runtime=python312 \
    --region=us-central1 \
    --source=. \
    --entry-point=hello_http \
    --trigger-http \
    --allow-unauthenticated
```

### Deploy with Run
```
 gcloud beta run deploy python-http-function \
    --source=. \
    --function=hello_http \
    --base-image=python312 \
    --region=us-central1 \
    --allow-unauthenticated
```

### Build with Cloud Build
gcloud builds submit --config cloudbuild.yaml --region northamerica-northeast2


## Misc
