import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_bloc.dart';
import 'package:funconnect/features/authentication/presentation/views/Profile_setup_view.dart';
import 'package:funconnect/features/authentication/presentation/views/email_verified_view.dart';
import 'package:funconnect/features/authentication/presentation/views/interest_view.dart';
import 'package:funconnect/features/authentication/presentation/views/verify_email_view.dart';
import 'package:funconnect/features/authentication/presentation/views/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/blocs/manage_login_options_bloc/manage_login_options_bloc.dart';
import 'package:funconnect/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/edit_profile_view.dart';
import 'package:funconnect/features/profile/presentation/views/manage_login_options_view.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/views/splash_view.dart';
import 'package:funconnect/success_view.dart';

import '../../features/events/presentation/views/create_event_view.dart';
import '../../features/events/presentation/views/event_description_view.dart';

class Routes {
  static const initialRoute = splashRoute;
  static const splashRoute = '/';
  static const onboardingRoute = '/onboarding';
  static const welcomeViewRoute = '/welcome-view';
  static const profileSetupViewRoute = '/profile_setup';
  static const editProfileViewRoute = '/edit-profile';
  static const manageLoginOptionsRoute = '/manage-login-options';
  // static const emailSignInRoute = '/email-sign-in';
  static const verifyEmailRoute = '/verify-email';
  static const emailVerifiedRoute = '/email-verified';
  static const locationAuthRoute = '/location-auth';
  static const successViewRoute = '/success-view';
  static const setUpProfile = '/setUp-Profile';
  static const interestViewRoute = '/interests';
  static const dashboardViewRoute = '/dashboard-view';

  // Events
  static const createEventRoute = '/create-event-route';
  static const eventDescriptionRoute = '/event-description-route';

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
        return MaterialPageRoute(builder: (_) => ProfileSetUpView());
      case interestViewRoute:
        return _registerBlocView(
          view: const InterestView(),
          bloc: InterestsBloc(),
        );
      // case locationAuthRoute:
      //   return MaterialPageRoute(builder: (_) => const LocationAuthView());
      case successViewRoute:
        return MaterialPageRoute(builder: (_) => const SuccessView());
      case dashboardViewRoute:
        return _registerBlocView(
          view: const DashboardView(),
          bloc: ProfileBloc(),
        );
      case createEventRoute:
        return MaterialPageRoute(builder: (_) => const CreateEventView());
      case eventDescriptionRoute:
        return MaterialPageRoute(builder: (_) => const EventDescriptionView());
        case editProfileViewRoute:
        return  _registerBlocView(
          view: const EditProfileView(),
          bloc: EditProfileBloc(),
        );
        case manageLoginOptionsRoute:
        return  _registerBlocView(
          view: const ManageLogInOptionsView(),
          bloc: ManageLoginOptionsBloc(),
        );
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

  static MaterialPageRoute _registerBlocView<T extends Bloc>({
    required Widget view,
    required T bloc,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<T>(
        create: (context) => bloc,
        child: view,
      ),
    );
  }
}
