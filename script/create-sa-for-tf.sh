# terraform 実行用のサービスアカウントを作成、権限を付与し、キーを取得する
# サービスアカウントの作成
# ex) make create-service-account SERVICE_ACCOUNT_NAME=サービスアカウントの名前 DESCRIPTION=説明文 DISPLAY_NAME=表示名
create-sa:
	gcloud iam service-accounts create $(SERVICE_ACCOUNT_NAME) \
		--description="$(DESCRIPTION)" \
		--display-name="$(DISPLAY_NAME)"

# サービスアカウントにロールを付与する
# ex) make assign-role PROJECT_ID=プロジェクトID SERVICE_ACCOUNT_NAME=サービスアカウントの名前
assign-role:
	gcloud projects add-iam-policy-binding $(PROJECT_ID) \
		--member="serviceAccount:$(SERVICE_ACCOUNT_NAME)@$(PROJECT_ID).iam.gserviceaccount.com" \
		--role="roles/editor"

# サービスアカウントのJSONキーを生成
# ex) make create-key SA=サービスアカウントの名前 PROJECT_ID=プロジェクトID
create-key:
	gcloud iam service-accounts keys create .credentials/key.json \
		--iam-account tf-account@${PROJECT_ID}.iam.gserviceaccount.com