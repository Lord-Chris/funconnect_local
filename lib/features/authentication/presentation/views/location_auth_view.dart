import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/authentication/presentation/blocs/location_auth_bloc/location_auth_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/location_auth_bloc/location_auth_event.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class LocationAuthView extends StatelessWidget {
  const LocationAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationAuthBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.048,
                  right: MediaQuery.of(context).size.width * 0.048,
                  top: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/small_logo.svg"),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "Easily Find Nearby Fun centers and important spots near you.",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        fontFamily: AppFonts.merriweather,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Allow location data",
                      textColor: Colors.white,
                      buttonColor: AppColors.primary,
                      function: () => context
                          .read<LocationAuthBloc>()
                          .add(RequestLocationPermissionEvent()),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Center(
                      child: Text(
                        "Not now",
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                          fontFamily: AppFonts.gtWalshPro,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 67)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
