import 'package:dumbdumb_flutter_app/app/assets/assets.g.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_structural_component.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_routing.dart';
import 'package:dumbdumb_flutter_app/app/assets/router/app_router.dart';
import 'package:dumbdumb_flutter_app/app/view/base_stateful_page.dart';
import 'package:dumbdumb_flutter_app/app/viewmodel/app_view_model.dart';


class SplashScreenPage extends BaseStatefulPage {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends BaseStatefulState<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _checkFirstRun();
    if (hasInternetConnection) {
      checkNewUpdate();
    }
  }

  Future<void> _checkFirstRun() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go(RouterPath.home);
    }
  }

  Future<void> checkNewUpdate() async {
    final remoteConfigRes =
        context.read<AppViewModel>().newVersionRemoteConfigResponse;
    if (!mounted || remoteConfigRes == null) return;

    await WidgetUtil.showRemoteConfigUpdateDialog(
        context: context,
        message: remoteConfigRes.message ?? '',
        updateUrl: remoteConfigRes.updateUrl ?? '',
        isForceUpdate: false);
  }

  @override
  Widget body() {
    return SizedBox.expand(
      child: Image.asset(Assets.icSplashScreen.path, fit: BoxFit.cover),
    );
  }

  @override
  bool topSafeAreaEnabled() => false;

  @override
  Color backgroundColor() => Colors.white;
}
