# bin/bash

PROJECT_ID=$0
SERVICE_ACCOUNT_NAME="tf-account"

gcloud config set project ${PROJECT_ID}

# サービスアカウントの作成
gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} \
    --description="terraform実行用サービスアカウント" \
    --display-name=${SERVICE_ACCOUNT_NAME}

# サービスアカウントにロールを付与する
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="roles/editor"

# サービスアカウントのJSONキーを生成
gcloud iam service-accounts keys create .credentials/${PROJECT_ID}-key.json \
    --iam-account tf-account@${PROJECT_ID}.iam.gserviceaccount.com