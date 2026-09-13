import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// makes it easier to create routes by using the string as the path and name of the route
extension GoRoutes on String {
  GoRoute route(Widget Function(BuildContext, GoRouterState) builder) {
    return GoRoute(path: this, name: substring(1), builder: builder);
  }
}

extension StringValidation on String {
  bool get isValidEmail {
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trim());
  }
}
