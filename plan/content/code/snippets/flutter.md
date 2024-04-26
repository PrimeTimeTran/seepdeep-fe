
### detect leaving the browser/tab

```dart
import 'dart:html' as html;

void main() {
  html.window.onBlur.listen((event) {
    // User switched tabs or unfocused the app
    print('User switched tabs or unfocused the app');
  });

  html.window.onVisibilityChange.listen((event) {
    if (html.document.visibilityState == 'hidden') {
      // User switched tabs or unfocused the app
      print('User switched tabs or unfocused the app');
    }
  });
}
```