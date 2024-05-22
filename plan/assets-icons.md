## Exporting from Illustrator

Assets for assets folder in Flutter

- Export from Illustrator:
  - Make line from stroke
  - Make compound path
  - [Recommended](https://github.com/dnfield/flutter_svg/tree/master/packages/flutter_svg)
  - Exporting from Asset Export(Options Config):
    - Styling: Presentation Attributes
    - Font: SVG
    - Images: Embed
    - Object IDs: Layer Names
    - Decimal: 1
    - Minify unchecked, responsive checked

### Benefits

- Change color
- Change size

```dart
SvgPicture.asset(
  'assets/icons/tangent-line.svg',
  height: 100,
  width: 100,
  color: Colors.red,
),
```

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
