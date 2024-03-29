import 'package:funconnect/features/authentication/data/dto/interest_model.dart';
import 'package:funconnect/features/authentication/domain/params/email_sign_in.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/params/verify_otp.dart';

import '../../../../core/models/_models.dart';
import '../dto/request_otp_response.dart';
import 'i_authentication_repository.dart';

class MockAuthenticationRepository extends IAuthenticationRepository {
  @override
  Future<UserModel?> signInWithApple(String code) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  @override
  Future<RequestOtpResponse> signInWithEmail(EmailSignInParams params) async {
    await Future.delayed(const Duration(seconds: 2));
    return const RequestOtpResponse(email: "", message: "", requestId: "");
  }

  @override
  Future<UserModel?> signInWithGoogle(String authCode) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  @override
  Future<UserModel?> signInWithGoogleIos(String idToken) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  @override
  Future<UserModel> verifyOtp(VerifyOtpParams params) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserModel.fromMap(
      const {
        'id': '98194b5c-f488-4a69-972f-179c2b7bff41',
        'email': 'maduekechris65@gmail.com',
        'name': 'Lord Chris',
        'username': 'theguy',
        'gender': 'female',
        'dob': null,
        'phone_e164': null,
        'location': {
          'id': '9826e5b4-98bd-41bf-b3e0-77b6e94f34d6',
          'user_id': '98194b5c-f488-4a69-972f-179c2b7bff41',
          'address': '1 Stockton St Stockton St',
          'city': 'San Francisco',
          'state': 'CA',
          'country': 'United States',
          'lat': 37.785834,
          'long': -122.406417
        },
        'bio': null,
        'twitter_handle': null,
        'facebook_handle': null,
        'instagram_handle': null,
        'linkedIn_handle': null,
        'api_token': '26|bYRKXHZ7VZ2fubGLi4HgxRajYDCUIUEUSvxZBglw'
      },
    );
  }

  @override
  Future<void> setUpProfile(ProfileSetupParam params) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<PaginatedData<InterestModel>> fetchInterests() async {
    await Future.delayed(const Duration(seconds: 2));
    return PaginatedData.fromMap(
      {
        "current_page": 1,
        "data": [
          {
            "id": "97f837d4-9e41-4084-a2c9-ec4ca0c1ad71",
            "name": "oadju",
            "status": "active"
          },
          {
            "id": "97f837d4-a0db-41d2-b3f0-8fccc5159644",
            "name": "bbple",
            "status": "active"
          },
          {
            "id": "97f837d4-a37b-433f-891d-c8e0d5c9b48d",
            "name": "xrkem",
            "status": "active"
          },
          {
            "id": "97f837d4-a590-40ad-80be-cdfe786f4daf",
            "name": "jcssk",
            "status": "active"
          },
          {
            "id": "97f837d4-e5f8-4143-8f86-051cba1ec42c",
            "name": "rewat",
            "status": "active"
          },
          {
            "id": "97f837d4-e8e6-4eef-9cda-b3add706e7f6",
            "name": "omrgc",
            "status": "active"
          },
          {
            "id": "97f837d4-eb46-4476-99b6-e1b7cf8a8bed",
            "name": "zgqom",
            "status": "active"
          },
          {
            "id": "97f837d5-0e78-42eb-91f8-784ca87c875a",
            "name": "hkrsm",
            "status": "active"
          },
          {
            "id": "97f837d5-33fc-4c7b-8bb8-15bb427cdce4",
            "name": "joacq",
            "status": "active"
          },
          {
            "id": "97f837d5-538d-447e-ab4e-c02c2d8ca4b3",
            "name": "vpvxe",
            "status": "active"
          },
          {
            "id": "97f837d5-5640-46df-81d3-34ab218dfaeb",
            "name": "pulks",
            "status": "active"
          },
          {
            "id": "97f837d5-58f9-4ac8-8fde-d124b243d4e6",
            "name": "myfjc",
            "status": "active"
          },
          {
            "id": "97f837d5-7ced-447a-a978-526d894c21ed",
            "name": "kgtwr",
            "status": "active"
          },
          {
            "id": "97f837d5-a0f4-41a2-87e5-84a8852db2ed",
            "name": "lhdwq",
            "status": "active"
          },
          {
            "id": "97f837d5-a2ea-43e3-8570-93ed99da9a56",
            "name": "evjdm",
            "status": "active"
          }
        ],
        "first_page_url": "https://places.funconnect.app/categories?page=1",
        "from": 1,
        "next_page_url": "https://places.funconnect.app/categories?page=2",
        "path": "https://places.funconnect.app/categories",
        "per_page": 15,
        "prev_page_url": null,
        "to": 15
      },
      (e) => InterestModel.fromMap(e),
    );
  }

  @override
  bool get isFirstTime => true;

  @override
  Future<void> saveInterests(List<InterestModel> interests) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
