import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_bloc.dart';
import 'package:funconnect/features/authentication/presentation/views/Profile_setup_view.dart';
import 'package:funconnect/features/authentication/presentation/views/email_verified_view.dart';
import 'package:funconnect/features/authentication/presentation/views/interest_view.dart';
import 'package:funconnect/features/authentication/presentation/views/verify_email_view.dart';
import 'package:funconnect/features/authentication/presentation/views/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/features/events/presentation/views/booking_view.dart';
import 'package:funconnect/features/events/presentation/views/checkout_view.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/views/place_detail_view.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/views/splash_view.dart';

import '../../features/events/presentation/views/create_event_view.dart';
import '../../features/events/presentation/views/event_description_view.dart';

class Routes {
  static const initialRoute = splashRoute;
  static const splashRoute = '/';
  static const onboardingRoute = '/onboarding';
  static const welcomeViewRoute = '/welcome-view';
  static const profileSetupViewRoute = '/profile_setup';
  static const verifyEmailRoute = '/verify-email';
  static const emailVerifiedRoute = '/email-verified';
  static const locationAuthRoute = '/location-auth';
  static const setUpProfile = '/setUp-Profile';
  static const interestViewRoute = '/interests';
  static const dashboardViewRoute = '/dashboard-view';
  static const createEventViewRoute = '/create-event-view';

  // Places
  static const placeDetailRoute = '/place-detail';

  // Events
  static const createEventRoute = '/create-event-route';
  static const eventDescriptionRoute = '/event-description-route';
  static const bookingRoute = '/booking-route';
  static const checkoutRoute = '/checkout-route';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case welcomeViewRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
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

      // Places
      case placeDetailRoute:
        return _registerBlocView(
          view: const PlaceDetailView(),
          bloc: PlaceDetailBloc(),
        );

      // Events
      case createEventViewRoute:
        return MaterialPageRoute(builder: (_) => const CreateEventView());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case eventDescriptionRoute:
        final event = settings.arguments as EventModel;
        return MaterialPageRoute(
          builder: (_) => EventDescriptionView(event: event),
        );
      case bookingRoute:
        return MaterialPageRoute(builder: (_) => const BookingView());
      case checkoutRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutView());
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
