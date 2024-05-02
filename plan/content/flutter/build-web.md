## Make a release

flutter build web --release

cd build/web

python -m http.server 80

netlify deploy
