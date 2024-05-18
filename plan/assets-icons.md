## Exporting from Illustrator

Assets for assets folder in Flutter

- Export from illustrator

  - Make line from stroke
  - Make compound path
  - Exporting from Asset Export(Options Config):
    - Styling: Inline Style
    - Font: SVG
    - Images: Preserve
    - Object IDs: Layer Names
    - Decimal: 1
    - Minify unchecked, responsive checked

## Exporting for fluttericon.com generation

Assets for upload to FlutterIcon for bundling

- Export from illustrator

  - Make line from stroke
  - Make compound path
  - Exporting from Asset Export(Options Config):
    - Styling: Internal CSS
    - Font: SVG
    - Images: Preserve
    - Object IDs: Layer Names
    - Decimal: 1
    - Minify unchecked, responsive checked

- Run script to remove style attribute from SVGs

```sh
  python3 ./assets/svgs/remove-style-attribute.py
```
