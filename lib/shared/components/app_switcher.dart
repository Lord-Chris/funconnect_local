import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class AppSwitcher extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;

  const AppSwitcher({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  Widget _inactiveMode() {
    return Container(
      key: UniqueKey(),
      padding: REdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray97),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 7.r,
            backgroundColor: AppColors.gray97,
          ),
          CircleAvatar(
            radius: 7.r,
            backgroundColor: AppColors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _activeMode() {
    return Container(
      key: UniqueKey(),
      padding: REdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 7.r,
            backgroundColor: AppColors.transparent,
          ),
          CircleAvatar(
            radius: 7.r,
            backgroundColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: InkWell(
        onTap: () => onChanged(!value),
        child: value ? _activeMode() : _inactiveMode(),
      ),
    );
  }
}
