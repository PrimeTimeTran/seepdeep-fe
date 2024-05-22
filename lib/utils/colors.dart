import 'package:flutter/material.dart';

themeColor(context, color) {
  switch (color) {
    case 'primary':
      return Theme.of(context).colorScheme.primary;
    case 'onPrimary':
      return Theme.of(context).colorScheme.onPrimary;
    case 'primaryContainer':
      return Theme.of(context).colorScheme.primaryContainer;
    case 'onPrimaryContainer':
      return Theme.of(context).colorScheme.onPrimaryContainer;

    case 'secondary':
      return Theme.of(context).colorScheme.secondary;
    case 'onSecondary':
      return Theme.of(context).colorScheme.onSecondary;
    case 'secondaryContainer':
      return Theme.of(context).colorScheme.secondaryContainer;
    case 'onSecondaryContainer':
      return Theme.of(context).colorScheme.onSecondaryContainer;
    case 'tertiary':
      return Theme.of(context).colorScheme.tertiary;
    case 'onTertiary':
      return Theme.of(context).colorScheme.onTertiary;
    case 'tertiaryContainer':
      return Theme.of(context).colorScheme.tertiaryContainer;
    case 'onTertiaryContainer':
      return Theme.of(context).colorScheme.onTertiaryContainer;

    case 'error':
      return Theme.of(context).colorScheme.error;
    case 'onError':
      return Theme.of(context).colorScheme.onError;
    case 'errorContainer':
      return Theme.of(context).colorScheme.errorContainer;
    case 'onErrorContainer':
      return Theme.of(context).colorScheme.onErrorContainer;

    case 'surface':
      return Theme.of(context).colorScheme.surface;
    case 'onSurface':
      return Theme.of(context).colorScheme.onSurface;

    case 'surfaceTint':
      return Theme.of(context).colorScheme.surfaceTint;

    case 'outline':
      return Theme.of(context).colorScheme.outline;
    case 'outlineVariant':
      return Theme.of(context).colorScheme.outlineVariant;

    case 'inverseSurface':
      return Theme.of(context).colorScheme.inverseSurface;
    case 'onInverseSurface':
      return Theme.of(context).colorScheme.onInverseSurface;
    case 'inversePrimary':
      return Theme.of(context).colorScheme.inversePrimary;

    case 'background':
      return Theme.of(context).colorScheme.background;
    case 'scrim':
      return Theme.of(context).colorScheme.scrim;
    case 'shadow':
      return Theme.of(context).colorScheme.shadow;
    default:
      throw Exception('Color does not exist.');
  }
}
