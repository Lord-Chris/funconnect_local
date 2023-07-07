import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_bloc.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(InitializeSplashEvent());
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        context.read<SplashBloc>().add(FinishSplashEvent());
      },
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          color: AppColors.mediumBlack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250.r,
                width: 250.r,
                child: SvgPicture.asset(
                  AppAssets.funconnectFullSvg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
