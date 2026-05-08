

import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';
import 'package:dumbdumb_flutter_app/app/view/bottom_navigation.dart';
import 'package:dumbdumb_flutter_app/app/view/splash_screen_page.dart';

class RouterName {
  static String splashScreen = 'splashScreen';
  static String login = 'login';
  static String home = 'home';
  static String digitalId = 'digitalId';
  static String attendance = 'attendance';
  static String profilePage = 'profilePage';
  static String announcementPage = 'announcementPage';
  static String announcementDetailPage = 'announcementDetailPage';
}

class RouterPath {
  static String splashScreen = '/';
  static String home = '/home';
  static String digitalId = '/digitalId';
  static String attendance = '/attendance';
  static String profilePage = '/profilePage';
  static String login = '/login';
  static String announcementPage = 'announcementPage';
  static String announcementDetailPage = 'announcementDetailPage';
}

class RouterNavigatorKeys {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final homeNavigatorKey = GlobalKey<NavigatorState>();
  static final addVenueNavigatorKey = GlobalKey<NavigatorState>();
  static final notificationNavigatorKey = GlobalKey<NavigatorState>();
  static final profileNavigatorKey = GlobalKey<NavigatorState>();
}

final GoRouter router = GoRouter(
  navigatorKey: RouterNavigatorKeys.rootNavigatorKey,
  initialLocation: RouterPath.splashScreen,
  routes: [
    StatefulShellRoute.indexedStack(
        parentNavigatorKey: RouterNavigatorKeys.rootNavigatorKey,
        builder: (context, state, navigationShell) =>
            BottomNavigation(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
              navigatorKey: RouterNavigatorKeys.homeNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.home,
                    name: RouterName.home,
                    builder: (context, state) => const MaintenancePage(),
                    routes: [
                      GoRoute(
                          path: RouterPath.announcementPage,
                          name: RouterName.announcementPage,
                          builder: (context, state) => const MaintenancePage(),
                        ),
                    ]),
              ]),
          StatefulShellBranch(
              navigatorKey: RouterNavigatorKeys.addVenueNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.digitalId,
                    name: RouterName.digitalId,
                    builder: (context, state) => const MaintenancePage(),
                    routes: []),
              ]),
          StatefulShellBranch(
              navigatorKey: RouterNavigatorKeys.notificationNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.attendance,
                    name: RouterName.attendance,
                    builder: (context, state) => const MaintenancePage(),
                    routes: []),
              ]),
          StatefulShellBranch(
              navigatorKey: RouterNavigatorKeys.profileNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                    path: RouterPath.profilePage,
                    name: RouterName.profilePage,
                    builder: (context, state) => const LoginPage(),
                    routes: [])
              ])
        ]),
    GoRoute(
      path: RouterPath.splashScreen,
      name: RouterName.splashScreen,
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
        path: RouterPath.login, builder: (context, state) => const LoginPage()),
  ],
);
