## Add environment vars when building

flutter build apk --dart-define=apiKey=YOUR_API_KEY

flutter build web --release --dart-define=FLUTTER_BASE_HREF='https://www.seepdeep.com' --dart-define=GEMINI_API_KEY=AIzaSyCOGROpRV464KETrdF7Ka8u07so9PmqfRY --dart-define=API_URL=https://seepdeep-api-dev-7d6537ynfa-uc.a.run.app/api/

flb web --release --dart-define=FLUTTER_BASE_HREF='https://www.seepdeep.com' --dart-define=GEMINI_API_KEY=AIzaSyCOGROpRV464KETrdF7Ka8u07so9PmqfRY --dart-define=API_URL=https://seepdeep-api-dev-7d6537ynfa-uc.a.run.app/api/

## Add environment vars when running

flutter run --dart-define=apiKey=YOUR_API_KEY

flutter run --dart-define=GEMINI_API_KEY=AIzaSyCOGROpRV464KETrdF7Ka8u07so9PmqfRY --dart-define=API_URL=https://seepdeep-api-dev-7d6537ynfa-uc.a.run.app/api/
