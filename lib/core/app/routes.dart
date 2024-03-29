import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';
import 'package:funconnect/features/authentication/presentation/interest/bloc/interest_bloc.dart';
import 'package:funconnect/features/authentication/presentation/interest/interest_view.dart';
import 'package:funconnect/features/authentication/presentation/profile_setup/bloc/profile_setup_bloc.dart';
import 'package:funconnect/features/authentication/presentation/profile_setup/profile_setup_view.dart';
import 'package:funconnect/features/authentication/presentation/verify_email/bloc/verify_email_bloc.dart';
import 'package:funconnect/features/authentication/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/welcome/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/dashboard_view.dart';
import 'package:funconnect/features/dashboard/presentation/notifications/notifications_view.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/features/events/presentation/views/booking_view.dart';
import 'package:funconnect/features/events/presentation/views/checkout_view.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

import 'package:funconnect/features/places/presentation/category_detail/bloc/category_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/category_detail/category_detail_view.dart';
import 'package:funconnect/features/places/presentation/place_detail/bloc/place_detail_bloc.dart';
import 'package:funconnect/features/places/presentation/place_detail/place_detail_view.dart';
import 'package:funconnect/features/places/presentation/search_result/search_result_view.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/plan_add_place_arguments.dart';
import 'package:funconnect/features/plans/presentation/add_place_to_plan/add_place_to_plan._view.dart';
import 'package:funconnect/features/plans/presentation/add_place_to_plan/bloc/add_place_to_plan_bloc.dart';

import 'package:funconnect/features/plans/presentation/choose_plan_type/bloc/choose_plan_type_bloc.dart';
import 'package:funconnect/features/plans/presentation/choose_plan_type/choose_plan_type_view.dart';
import 'package:funconnect/features/plans/presentation/create_plan/bloc/create_plan_bloc.dart';
import 'package:funconnect/features/plans/presentation/create_plan/create_plan_view.dart';
import 'package:funconnect/features/plans/presentation/map/bloc/map_bloc.dart';
import 'package:funconnect/features/plans/presentation/map/map_view.dart';
import 'package:funconnect/features/plans/presentation/plan_add_place/add_plan_place.dart';
import 'package:funconnect/features/plans/presentation/plan_add_place/bloc/plan_add_place_bloc.dart';
import 'package:funconnect/features/plans/presentation/plan_details/bloc/plan_details_bloc.dart';
import 'package:funconnect/features/plans/presentation/plan_details/plan_details_view.dart';
import 'package:funconnect/features/plans/presentation/plan_list/bloc/plan_list_bloc.dart';
import 'package:funconnect/features/plans/presentation/plan_list/plans_list_view.dart';

import 'package:funconnect/features/profile/presentation/edit_profile/edit_profile_view.dart';
import 'package:funconnect/features/profile/presentation/manage_login_options/manage_login_options_view.dart';
import 'package:funconnect/features/profile/presentation/views/my_events_view.dart';
import 'package:funconnect/features/profile/presentation/views/my_tickets_view.dart';
import 'package:funconnect/features/saved/presentation/collections/create_collection_view.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_bloc.dart';
import 'package:funconnect/features/saved/presentation/saved/saved_view.dart';
import 'package:funconnect/features/startup/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/onboarding/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_bloc.dart';
import 'package:funconnect/features/startup/presentation/splash/splash_view.dart';
import 'package:funconnect/features/startup/presentation/version_update/version_update_view.dart';
import 'package:funconnect/features/webview/presentation/blocs/webview_bloc/webview_bloc.dart';
import 'package:funconnect/features/webview/presentation/views/webview_screen.dart';

import '../../features/authentication/presentation/verify_email/email_verified_view.dart';
import '../../features/authentication/presentation/verify_email/verify_email_view.dart';
import '../../features/dashboard/presentation/notifications/bloc/notification_bloc.dart';
import '../../features/events/presentation/views/create_event_view.dart';
import '../../features/events/presentation/views/event_description_view.dart';
import '../../features/places/domain/entities/category_model.dart';
import '../../features/places/presentation/search_result/bloc/search_result_bloc.dart';
import '../../features/profile/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import '../../features/profile/presentation/manage_login_options/bloc/manage_login_options_bloc.dart';
import '../../features/profile/presentation/views/rate_your_experience_view.dart';

class Routes {
  // Onboarding
  static const initialRoute = splashRoute;
  static const splashRoute = '/';
  static const versionUpdateRoute = '/version-update';
  static const onboardingRoute = '/onboarding';
  static const welcomeViewRoute = '/welcome-view';
  // static const emailSignInRoute = '/email-sign-in';
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
  static const categoryDetailRoute = '/category-detail';
  static const searchResultRoute = '/search-result';
  static const addPlaceToPlanRoute = '/add-place-to-plan';

  // Events
  static const createEventRoute = '/create-event-route';
  static const eventDescriptionRoute = '/event-description-route';
  static const bookingRoute = '/booking-route';
  static const checkoutRoute = '/checkout-route';

  // Saved
  static const savedViewRoute = '/saved-view';
  static const createCollectionViewRoute = '/create-collection-view';

  //Planner

  static const plannerListViewRoute = '/planner-list-view';
  static const choosePlanTypeViewRoute = '/choose-plan-type-view';
  static const createPlanViewRoute = '/create-plan-view';
  static const plannerMapRoute = '/planner-map';
  static const planDetailViewRoute = '/plan-detail-view';
  static const planAddPlaceViewRoute = '/plan-add-place-view';

  // Profile
  static const editProfileViewRoute = '/edit-profile';
  static const profileSetupViewRoute = '/profile_setup';
  static const manageLoginOptionsRoute = '/manage-login-options';
  static const rateYourExperienceRoute = '/rate-your-experience';
  static const myTicketRoute = '/my-ticket';
  static const myEventRoute = '/my-event';

  // webview
  static const webViewRoute = '/web-view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding
      case splashRoute:
        return _registerBlocView(
          view: const SplashView(),
          bloc: SplashBloc(),
          settings: settings,
        );
      case versionUpdateRoute:
        return MaterialPageRoute(builder: (_) => const VersionUpdateView());
      case onboardingRoute:
        return _registerBlocView(
          view: const OnboardingView(),
          bloc: OnboardingBloc(),
          settings: settings,
        );
      case welcomeViewRoute:
        return _registerBlocView(
          view: const WelcomeView(),
          bloc: WelcomeBloc(),
          settings: settings,
        );
      case verifyEmailRoute:
        final res = settings.arguments as RequestOtpResponse;
        return _registerBlocView(
          view: VerifyEmailView(response: res),
          bloc: VerifyEmailBloc(),
          settings: settings,
        );
      case emailVerifiedRoute:
        final res = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => EmailVerifiedScreen(user: res),
        );
      case profileSetupViewRoute:
        return _registerBlocView(
          view: ProfileSetUpView(user: settings.arguments as UserModel),
          bloc: ProfileSetupBloc(),
          settings: settings,
        );
      case interestViewRoute:
        return _registerBlocView(
          view: const InterestView(),
          bloc: InterestsBloc(),
          settings: settings,
        );

      // Places
      case placeDetailRoute:
        final place = settings.arguments as PlaceModel;
        return _registerBlocView(
          view: PlaceDetailView(place: place),
          bloc: PlaceDetailBloc(),
          settings: settings,
        );

      case categoryDetailRoute:
        final category = settings.arguments as CategoryModel;
        return _registerBlocView(
          view: CategoryDetailView(category: category),
          bloc: CategoryDetailBloc(),
          settings: settings,
        );

      case searchResultRoute:
        return _registerBlocView(
          view: const SearchResultView(),
          bloc: SearchResultBloc(),
          settings: settings,
        );

      case addPlaceToPlanRoute:
        final place = settings.arguments as FullPlaceModel;
        return _registerBlocView(
          view: AddPlaceToPlan(place: place),
          bloc: AddPlaceToPlanBloc(),
          settings: settings,
        );

      // Dashboard
      case dashboardViewRoute:
        return _registerBlocView(
          bloc: DashboardBloc(),
          view: const DashboardView(),
          settings: settings,
        );

      case notificationsViewRoute:
        return _registerBlocView(
          view: const NotificationsView(),
          bloc: NotificationBloc(),
          settings: settings,
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

      // Saved
      case savedViewRoute:
        return _registerBlocView(
          bloc: SavedBloc(),
          view: const SavedView(),
          settings: settings,
        );

      case createCollectionViewRoute:
        return MaterialPageRoute(builder: (_) => const CreateCollectionView());

      // Planner
      case plannerListViewRoute:
        return _registerBlocView(
          bloc: PlanListBloc(),
          view: const PlansListView(),
          settings: settings,
        );

      case createPlanViewRoute:
        return _registerBlocView(
          bloc: CreatePlanBloc(),
          view: const CreatePlanView(),
          settings: settings,
        );

      case choosePlanTypeViewRoute:
        return _registerBlocView(
          bloc: ChoosePlanTypeBloc(),
          view: const ChoosePlanTypeView(),
          settings: settings,
        );

      case plannerMapRoute:
        return _registerBlocView(
          view: const PlannerMapView(),
          bloc: MapBloc(),
          settings: settings,
        );
      case planDetailViewRoute:
        final plan = settings.arguments as MiniPlanModel;
        return _registerBlocView(
          view: PlanDetailsView(plan: plan),
          bloc: PlanDetailsBloc(),
          settings: settings,
        );

      case planAddPlaceViewRoute:
        final arguments = settings.arguments as PLanAddPLaceArguments;
        return _registerBlocView(
          view: AddPlanPlaceView(
            arguments: arguments,
          ),
          bloc: PlanAddPlaceBloc()
            ..add(PlanAddPlaceInitialEvent(arguments: arguments)),
          settings: settings,
        );

      // Profile
      case editProfileViewRoute:
        final profile = settings.arguments as UserModel;
        return _registerBlocView(
          view: const EditProfileView(),
          bloc: EditProfileBloc(profile),
          settings: settings,
        );
      case manageLoginOptionsRoute:
        final profile = settings.arguments as UserModel;
        return _registerBlocView(
          view: const ManageLogInOptionsView(),
          bloc: ManageLoginOptionsBloc(profile),
          settings: settings,
        );
      case rateYourExperienceRoute:
        return MaterialPageRoute(
          builder: (_) => const RateYourExperienceView(),
        );

      case myTicketRoute:
        return MaterialPageRoute(builder: (_) => const MyTicketView());

      case myEventRoute:
        return MaterialPageRoute(builder: (_) => const MyEventsView());
      case webViewRoute:
        String link = settings.arguments as String;
        return _registerBlocView(
          view: WebViewScreen(link: link),
          settings: settings,
          bloc: WebviewBloc(),
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
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => BlocProvider<T>(
        create: (context) => bloc,
        child: view,
      ),
    );
  }
}
