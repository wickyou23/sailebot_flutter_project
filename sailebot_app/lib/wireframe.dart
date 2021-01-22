import 'package:flutter/widgets.dart';
import 'package:sailebot_app/screens/auth/authentication_screen.dart';
import 'package:sailebot_app/screens/auth/change_password_screen.dart';
import 'package:sailebot_app/screens/auth/change_password_success_screen.dart';
import 'package:sailebot_app/screens/auth/reset_password_screen.dart';
import 'package:sailebot_app/screens/auth/update_password_screen.dart';
import 'package:sailebot_app/screens/homes/home_screen.dart';
import 'package:sailebot_app/screens/homes/preview_developing_screen.dart';
import 'package:sailebot_app/screens/introduce/introduce_screen.dart';
import 'package:sailebot_app/screens/notification/notification_detail_screen.dart';
import 'package:sailebot_app/screens/notification/notification_screen.dart';
import 'package:sailebot_app/screens/sailebot/sailebot_request_campaign_screen.dart';
import 'package:sailebot_app/screens/sailebot/sailebot_setting_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/confirmation_completed_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/confirmation_save_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/intro_questionaire_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/personality_question.screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/product_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/prospects_question_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/resume_questionaire_screen.dart';
import 'package:sailebot_app/screens/sailebot_setup/sailebot_setup_confirm_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_build_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_intro_screen.dart';
import 'package:sailebot_app/screens/sailebot_swipe/sailebot_swipe_screen.dart';
import 'package:sailebot_app/screens/settings/policy_setting_screen.dart';
import 'package:sailebot_app/screens/settings/settings_screen.dart';
import 'package:sailebot_app/screens/settings/tos_setting_screen.dart';
import 'package:sailebot_app/screens/splash/splash_screen.dart';
import 'package:sailebot_app/screens/support/support_screen.dart';
import 'package:sailebot_app/screens/users/proffile_detail_screen.dart';
import 'package:sailebot_app/screens/users/update_profile_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/services/questionaire_service.dart';
import 'package:sailebot_app/utils/extension.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    AuthenticationScreen.routeName: (ctx) {
      bool shouldShowSignupFirst = true;
      Object arg = ctx.routeArg;
      if (arg is Map<String, bool>) {
        shouldShowSignupFirst = arg['shouldShowSignupFirst'] ?? true;
      }

      return AuthenticationScreen(
        shouldShowSignupFirst: shouldShowSignupFirst,
      );
    },
    IntroduceScreen.routeName: (_) => IntroduceScreen(),
    ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
    UpdatePasswordScreen.routeName: (_) => UpdatePasswordScreen(),
    UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
    SaileBotSetupConfirmScreen.routeName: (ctx) {
      bool shouldShowBuildSailebotFirst = false;
      bool isPush = false;
      Object arg = ctx.routeArg;
      if (arg is Map<String, bool>) {
        shouldShowBuildSailebotFirst =
            arg['shouldShowBuildSailebotFirst'] ?? false;
        isPush = arg['isPush'] ?? false;
      }

      return SaileBotSetupConfirmScreen(
        shouldShowBuildSailebotFirst: shouldShowBuildSailebotFirst,
        isPush: isPush,
      );
    },
    HomeScreen.routeName: (_) => HomeScreen(),
    SaileBotSwipeIntroScreen.routeName: (_) => SaileBotSwipeIntroScreen(),
    SaileBotSwipeScreen.routeName: (_) => SaileBotSwipeScreen(),
    SaileBotSwipeBuildScreen.routeName: (_) => SaileBotSwipeBuildScreen(),
    PreviewDevelopingScreen.routeName: (_) => PreviewDevelopingScreen(),
    SaileBotSettingScreen.routeName: (_) => SaileBotSettingScreen(),
    SaileBotReqCampaignScreen.routeName: (_) => SaileBotReqCampaignScreen(),
    SettingScreen.routeName: (_) => SettingScreen(),
    TOSSettingScreen.routeName: (_) => TOSSettingScreen(),
    PolicySettingScreen.routeName: (_) => PolicySettingScreen(),
    SupportScreen.routeName: (_) => SupportScreen(),
    NotificationScreen.routeName: (_) => NotificationScreen(),
    NotificationDetailScreen.routeName: (_) => NotificationDetailScreen(),
    ProfileDetailScreen.routeName: (_) => ProfileDetailScreen(),
    ChangePasswordScreen.routeName: (_) => ChangePasswordScreen(),
    ChangePasswordSuccessScreen.routeName: (_) => ChangePasswordSuccessScreen(),
    ProductQuestionScreen.routeName: (_) => ProductQuestionScreen(),
    ProspectsQuestionScreen.routeName: (_) => ProspectsQuestionScreen(),
    IntroQuestionaireScreen.routeName: (_) => IntroQuestionaireScreen(),
    PersonalityQuestionScreen.routeName: (_) => PersonalityQuestionScreen(),
    ConfirmationSaveQuestionScreen.routeName: (_) =>
        ConfirmationSaveQuestionScreen(),
    SplashScreen.routeName: (_) => SplashScreen(),
    ResumeQuestionaireScreen.routeName: (_) => ResumeQuestionaireScreen(),
    ConfirmationCompletedQuestionScreen.routeName: (_) =>
        ConfirmationCompletedQuestionScreen(),
  };

  static void logout() {
    LocalStoreService().removeAllCache();
    QuestionaireService().clean();
  }
}
