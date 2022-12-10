import 'package:flutter/material.dart';
import 'package:funconnect/features/authentication/presentation/views/Profile_setup_view.dart';
import 'package:funconnect/features/authentication/presentation/views/email_verified_view.dart';
import 'package:funconnect/features/authentication/presentation/views/verify_email_view.dart';
import 'package:funconnect/features/authentication/presentation/views/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/views/splash_view.dart';
import 'package:funconnect/success_view.dart';

class Routes {
  static const initialRoute = splashRoute;
  static const splashRoute = '/';
  static const onboardingRoute = '/onboarding';
  static const welcomeViewRoute = '/welcome-view';
  static const profileSetupViewRoute = '/profile_setup';
  // static const emailSignInRoute = '/email-sign-in';
  static const verifyEmailRoute = '/verify-email';
  static const emailVerifiedRoute = '/email-verified';
  static const locationAuthRoute = '/location-auth';
  static const successViewRoute = '/success-view';
  static const setUpProfile = '/setUp-Profile';
  static const dashboardViewRoute = '/dashboard-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case welcomeViewRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      // case emailSignInRoute:
      //   return MaterialPageRoute(builder: (_) => const EmailSigninView());
      case verifyEmailRoute:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerifyEmailView(email: email),
        );
      case emailVerifiedRoute:
        return MaterialPageRoute(builder: (_) => const EmailVerifiedScreen());
      case profileSetupViewRoute:
        return MaterialPageRoute(builder: (_) => const ProfileSetUpView());
      // case locationAuthRoute:
      //   return MaterialPageRoute(builder: (_) => const LocationAuthView());
      case successViewRoute:
        return MaterialPageRoute(builder: (_) => const SuccessView());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
