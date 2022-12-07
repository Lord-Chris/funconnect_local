import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc()..add(InitializeSplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashFinishedState) {
            context.read<SplashBloc>().add(FinishSplashEvent());
          }
        },
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            color: AppColors.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(
                //   AppAssets.splashUpSvg,
                //   width: 370,
                // ),
                const Spacer(),
                SvgPicture.asset(
                  AppAssets.funconnectSvg,
                  width: 136,
                  height: 24,
                ),
                const Spacer(),
                // Stack(
                //   children: [
                //     SvgPicture.asset(
                //       AppAssets.splashDownSvg,
                //       width: 370,
                //       // width: 331,
                //       // height: 331,
                //     ),
                //     const Positioned(
                //       bottom: 40,
                //       left: 0,
                //       right: 0,
                //       child: Center(
                //         child: Text(
                //           "Funconnect Technologies",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w300,
                //             height: 1.3,
                //             fontFamily: AppFonts.gtWalshPro,
                //             fontStyle: FontStyle.normal,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
