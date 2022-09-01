import 'package:flutter/material.dart';
import 'package:funconnect/email_signin_view.dart';
import 'package:funconnect/features/splash_screen.dart';
import 'package:funconnect/location_auth.dart';
import 'package:funconnect/onboarding_view.dart';
import 'package:funconnect/success_view.dart';
import 'package:funconnect/verify_email_view.dart';
import 'package:funconnect/welcome_view.dart';

class Routes {
  static const splashRoute = '/';
  static const onboardingRoute = '/onboarding';
  static const welcomeViewRoute = '/welcome-view';
  static const emailSignInRoute = '/email-sign-in';
  static const verifyEmailRoute = '/verify-email';
  static const locationAuthRoute = '/location-auth';
  static const successViewRoute = '/success-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case welcomeViewRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      case emailSignInRoute:
        return MaterialPageRoute(builder: (_) => const EmailSigninView());
      case verifyEmailRoute:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case locationAuthRoute:
        return MaterialPageRoute(
            builder: (_) => const LocationAuthentication());
      case successViewRoute:
        return MaterialPageRoute(builder: (_) => const SuccessView());
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
