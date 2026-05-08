

import 'package:dumbdumb_flutter_app/app/assets/constants/enums/bottom_nav_enum.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';

class BottomNavigation extends BaseStatefulPage {
  const BottomNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  DateTime? _currentBackPressTime;
  final _dismissDuration = Duration(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: _currentBackPressTime != null,
        onPopInvokedWithResult: (didPop, result) {
          onPopInvoked();
        },
        child: Scaffold(
            body: widget.navigationShell,
            bottomNavigationBar: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: Offset(0, -2))
                ]),
                child: DefaultTabController(
                    length: BottomNavEnum.values.length,
                    initialIndex: widget.navigationShell.currentIndex,
                    child: Theme(
                        data: context.theme.copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent),
                        child: BottomNavigationBar(
                            backgroundColor: Colors.white,
                            type: BottomNavigationBarType.fixed,
                            currentIndex: widget.navigationShell.currentIndex,
                            onTap: onTapItem,
                            selectedLabelStyle:
                                context.theme.textTheme.titleLarge?.copyWith(
                                    color: AppPalette.blue.shade800,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                            unselectedLabelStyle:
                                context.theme.textTheme.titleLarge?.copyWith(
                                    color: AppPalette.gray.shade300,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                            showSelectedLabels: true,
                            showUnselectedLabels: true,
                            elevation: 0,
                            useLegacyColorScheme: false,
                            items: BottomNavEnum.values
                                .map((ele) => BottomNavigationBarItem(
                                    label: ele.tapName,
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Image.asset(
                                          widget.navigationShell.currentIndex ==
                                                  ele.index
                                              ? ele.activeIcon
                                              : ele.icon),
                                    )))
                                .toList()))))));
  }

  void onTapItem(int selectedIndex) {
    context.go(BottomNavEnum.values[selectedIndex].path,
        extra: GoRouterState.of(context).extra);
  }

  void onPopInvoked() async {
    final latestPath =
        router.routerDelegate.currentConfiguration.last.route.path;

    if ([
      RouterPath.home,
      RouterPath.digitalId,
      RouterPath.attendance,
      RouterPath.profilePage
    ].contains(latestPath)) {
      final now = DateTime.now();

      if (_currentBackPressTime == null ||
          now.difference(_currentBackPressTime!) > _dismissDuration) {
        await WidgetUtil.showSnackBar(S.current.mandarin);

        setState(() => _currentBackPressTime = DateTime.now());

        resetBackPressedFlag();
      }
    }
  }

  void resetBackPressedFlag() {
    Timer.periodic(Duration(milliseconds: 1500), (Timer t) {
      if (mounted) {
        setState(() => _currentBackPressTime = null);
        t.cancel();
      }
    });
  }
}
