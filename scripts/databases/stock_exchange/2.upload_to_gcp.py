import os
import datetime
from google.cloud import storage

def upload_to_gcs(bucket_name, local_file_path, destination_blob_name):
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/Users/future/.config/gcloud/application_default_credentials.json"
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(local_file_path)

    print(f"File {local_file_path} uploaded to {destination_blob_name} in bucket {bucket_name}")

today = datetime.datetime.today().strftime('%Y-%m-%d')
bucket_name = 'turboship-dev-alpha'
local_file_path = f'stocks-{today}.json'
destination_blob_name = f'stocks-{today}.json'

upload_to_gcs(bucket_name, local_file_path, destination_blob_name)
