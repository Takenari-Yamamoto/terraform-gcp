
# GCPのプロジェクトを表示する
show-prj:
	gcloud config get-value project

config-list:
	gcloud config list

projects-list:
	gcloud projects list

# GCPのアクティブなプロジェクトを変更する
# ex) make activate-prj PROJECT_ID=sample-project
activate-prj:
	gcloud config set project $(PROJECT_ID)

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
