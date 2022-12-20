import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/app_auth_text_form_field.dart';
import '../../../../core/presentation/widgets/app_black_modal.dart';
import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../core/presentation/widgets/app_text.dart';

class WelcomeView extends HookWidget {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
        return Scaffold(
          body: AppBlackModalWidget(
            imageContainerHeight: 400.0,
            modalHeight: 480.0,
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppText.aTAuthWelcomeText,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 24.0),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      AppText.aTAuthContinueWithSocialsText,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => context
                              .read<WelcomeBloc>()
                              .add(GoogleSignInEvent()),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () => context
                              .read<WelcomeBloc>()
                              .add(AppleSignInEvent()),
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            AppText.aTAuthEmailID,
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                        Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width / 4,
                          color: Colors.white,
                        ),
                        const Divider(
                          height: 5.0,
                          thickness: 5.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    AppTextForm(
                      labelText: AppText.aTAuthEmailText,
                      controller: controller,
                      validator: context.validateEmail,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Text(
                      AppText.aTAuthAgreementText,
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    AppOrangeBtn(
                      label: AppText.aTAuthSignUpText,
                      onTap: () {
                        // print(!formKey.currentState!.validate());
                        if (!formKey.currentState!.validate()) return;
                        // print("Yes");
                        context.read<WelcomeBloc>().add(EmailSignInEvent(
                            email: "maduekechris65@gmail.com"));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
