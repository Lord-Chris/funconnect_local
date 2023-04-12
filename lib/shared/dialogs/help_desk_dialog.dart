import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/extensions/_extensions.dart';
import 'package:funconnect/core/models/_models.dart';

import '../components/_components.dart';
import '../constants/_constants.dart';

class HelpDeskDialog extends HookWidget {
  const HelpDeskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: AppColors.interestWidgetAsh,
        ),
        child: HookBuilder(
          builder: (context) {
            final title = useTextEditingController();
            final body = useTextEditingController();
            return Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Help Desk',
                    style: AppTextStyles.medium20,
                  ),
                  Spacing.vertMedium(),
                  AppTextField(
                    label: 'Title',
                    hint: 'Title',
                    controller: title,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    validator: context.validateNotEmpty,
                  ),
                  Spacing.vertRegular(),
                  AppTextField(
                    label: 'Body',
                    hint: 'Body of your request',
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    controller: body,
                    validator: context.validateNotEmpty,
                    maxLines: 6,
                  ),
                  Spacing.vertMedium(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Spacing.horizRegular(),
                      Expanded(
                        child: AppButton(
                          onTap: () {
                            if (!key.currentState!.validate()) return;
                            Navigator.pop(
                                context,
                                HelpDeskData(
                                  title: title.text,
                                  body: body.text,
                                ));
                          },
                          label: "Send",
                          buttonColor: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
