## Make a release

flutter build web --release

cd build/web

python -m http.server 8080

netlify deploy
