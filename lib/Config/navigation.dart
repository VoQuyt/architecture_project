part of lib_config;

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static NavigatorState get stateRoot => navigatorKey.currentState!;
  static BuildContext get rootContext => navigatorKey.currentContext!;
  static Size size = MediaQuery.of(rootContext).size;

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static void popUntilTo(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static Future<dynamic> replacementTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> replacementAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  static Future<dynamic> pushReplacement(Widget component,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
        builder: (_) => component,
        settings: RouteSettings(arguments: arguments)));
  }

  static Future<dynamic> pushAndRemoveUntil(Widget component,
      {Object? arguments}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => component,
            settings: RouteSettings(arguments: arguments)),
        (route) => false);
  }

  static Future<dynamic> push(Widget component,
      {Object? arguments, String? name}) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => component,
        settings: RouteSettings(arguments: arguments, name: name)));
  }

  static void pop() {
    navigatorKey.currentState!.pop();
  }
}
