// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
// import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';

// import '../../../../shared/constants/_constants.dart';

// class ExploreSection extends StatelessWidget {
//   final String section;
//   final bool isSelected;
//   const ExploreSection({
//     Key? key,
//     required this.section,
//     required this.isSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () =>
//           context.read<HomeBloc>().add(InterestTapEvent(interest: section)),
//       child: Container(
//         padding: REdgeInsets.fromLTRB(8, 4, 8, 4),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: isSelected ? AppColors.primary : AppColors.interestWidgetAsh,
//         ),
//         child: Text(
//           section,
//           maxLines: 1,
//           style: AppTextStyles.regular12,
//         ),
//       ),
//     );
//   }
// }
