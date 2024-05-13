import os
from google.cloud import storage

def upload_to_gcs(bucket_name, local_file_path, destination_blob_name):
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/Users/future/.config/gcloud/application_default_credentials.json"
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(local_file_path)

    print(f"File {local_file_path} uploaded to {destination_blob_name} in bucket {bucket_name}")
bucket_name = 'turboship-dev-alpha'
local_file_path = 'stocks-2024-05-13.json'
destination_blob_name = 'stocks-2024-05-13.json'

upload_to_gcs(bucket_name, local_file_path, destination_blob_name)
