import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';
import 'package:funconnect/features/authentication/presentation/blocs/interest_bloc/interest_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/verify_email_bloc/verify_email_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_bloc.dart';
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
import 'package:funconnect/features/places/presentation/views/notifications_view.dart';
import 'package:funconnect/features/places/presentation/views/place_detail_view.dart';
import 'package:funconnect/features/profile/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/blocs/profile/profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/edit_profile_view.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/views/splash_view.dart';

import '../../features/events/presentation/views/create_event_view.dart';
import '../../features/events/presentation/views/event_description_view.dart';

class Routes {
  // Onboarding
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

  // Dashboard
  static const dashboardViewRoute = '/dashboard-view';
  static const notificationsViewRoute = '/notifications-view';

  // Places
  static const placeDetailRoute = '/place-detail';

  // Events
  static const createEventRoute = '/create-event-route';
  static const eventDescriptionRoute = '/event-description-route';
  static const bookingRoute = '/booking-route';
  static const checkoutRoute = '/checkout-route';

  // Profile
  static const editProfileViewRoute = '/edit-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding
      case splashRoute:
        return _registerBlocView(
          view: const SplashView(),
          bloc: SplashBloc(),
        );
      case onboardingRoute:
        return _registerBlocView(
          view: const OnboardingView(),
          bloc: OnboardingBloc(),
        );
      case welcomeViewRoute:
        return _registerBlocView(
          view: const WelcomeView(),
          bloc: WelcomeBloc(),
        );
      case verifyEmailRoute:
        final res = settings.arguments as RequestOtpResponse;
        return _registerBlocView(
          view: VerifyEmailView(response: res),
          bloc: VerifyEmailBloc(),
        );
      case emailVerifiedRoute:
        return _registerBlocView(
          view: const EmailVerifiedScreen(),
          bloc: VerifyEmailBloc(),
        );
      case profileSetupViewRoute:
        return _registerBlocView(
          view: ProfileSetUpView(),
          bloc: ProfileSetupBloc(),
        );
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

      // Dashboard
      case dashboardViewRoute:
        return _registerBlocView(
          view: const DashboardView(),
          bloc: ProfileBloc(),
        );

      case notificationsViewRoute:
        return _registerBlocView(
          view: const NotificationsView(),
          bloc: ProfileBloc(),
        );
      // Events
      case createEventRoute:
        return MaterialPageRoute(builder: (_) => const CreateEventView());

      case eventDescriptionRoute:
        final event = settings.arguments as EventModel;
        return MaterialPageRoute(
          builder: (_) => EventDescriptionView(event: event),
        );
      case bookingRoute:
        return MaterialPageRoute(builder: (_) => const BookingView());
      case checkoutRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutView());

      // Profile
      case editProfileViewRoute:
        return _registerBlocView(
          view: const EditProfileView(),
          bloc: EditProfileBloc(),
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
