class AppConstants {
  static AppConstants? _instance;

  static AppConstants get instance {
    _instance ??= AppConstants._init();
    return _instance!;
  }

  AppConstants._init() {
    APP_LOGO = "assets/images/app_logos/pooly_logo.jpg";

    APP_LOGO_TRANSPARENT = "assets/images/app_logos/pooly_logo_transparent.png";
    PROFILE_AVATAR = "assets/images/user_profiles/avatar.png";
    PROFILE_JORDAN = "assets/images/user_profiles/jordan.png";
    PROFILE_KEVIN = "assets/images/user_profiles/jordan.png";
    PROFILE_KYRIE = "assets/images/user_profiles/kyrie.png";
    PROFILE_LEBRON = "assets/images/user_profiles/lebron.png";
    PROFILE_STEPH = "assets/images/user_profiles/steph.png";
  }
  late final String APP_LOGO;
  late final String APP_LOGO_TRANSPARENT;
  late final String PROFILE_JORDAN;
  late final String PROFILE_AVATAR;

  late final String PROFILE_KEVIN;
  late final String PROFILE_KYRIE;
  late final String PROFILE_LEBRON;
  late final String PROFILE_STEPH;
}
