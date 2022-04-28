/*
  Contains all the files which are based on the application screens navigation.
*/
part of lib_config;

final Map<String, Widget Function(BuildContext)> _routes = {
  //Screen router define here...
};

MaterialPageRoute buildWidgetsRoute(RouteSettings routeSettings) {
  //Hardle deeplink here if builder doesn`t initialized yet
  Widget Function(BuildContext)? builder = _routes[routeSettings.name];
  if (builder == null) {
    throw Exception(['Not found route with name is: ${routeSettings.name}']);
  }
  return MaterialPageRoute(builder: builder, settings: routeSettings);
}
