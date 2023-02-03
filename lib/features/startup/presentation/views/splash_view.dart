import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            color: AppColors.mediumBlack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/gifs/funconnect_logo.gif",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


