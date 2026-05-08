import 'package:dumbdumb_flutter_app/app/assets/assets.g.dart';
import 'package:dumbdumb_flutter_app/app/assets/router/app_router.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';

enum BottomNavEnum {
  home,
  announcement,
  attendance,
  profile;

  String get tapName {
    switch (this) {
      case BottomNavEnum.home:
        return S.current.english;
      case BottomNavEnum.announcement:
        return S.current.english;
      case BottomNavEnum.attendance:
        return S.current.english;
      case BottomNavEnum.profile:
        return S.current.english;
    }
  }

  String get icon {
    switch (this) {
      case BottomNavEnum.home:
        return Assets.icHome.path;
      case BottomNavEnum.announcement:
        return Assets.icIdDigital.path;
      case BottomNavEnum.attendance:
        return Assets.icClock.path;
      case BottomNavEnum.profile:
        return Assets.icProfile.path;
    }
  }

  String get activeIcon {
    switch (this) {
      case BottomNavEnum.home:
        return Assets.icHomeActive.path;
      case BottomNavEnum.announcement:
        return Assets.icIdDigitalActive.path;
      case BottomNavEnum.attendance:
        return Assets.icClockActive.path;
      case BottomNavEnum.profile:
        return Assets.icProfileActive.path;
    }
  }

  String get path {
    switch (this) {
      case BottomNavEnum.home:
        return RouterPath.home;
      case BottomNavEnum.announcement:
        return RouterPath.digitalId;
      case BottomNavEnum.attendance:
        return RouterPath.attendance;
      case BottomNavEnum.profile:
        return RouterPath.profilePage;
    }
  }
}
