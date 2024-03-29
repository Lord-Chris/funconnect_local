// import 'package:flutter/material.dart';
// import 'package:funconnect/shared/components/_components.dart';
// import 'package:funconnect/shared/constants/_constants.dart';

// class AppOrangeBtn extends StatelessWidget {
//   final String label;
//   final double height;
//   final double? weight;
//   final VoidCallback? onTap;
//   final bool isBusy;

//   const AppOrangeBtn({
//     Key? key,
//     required this.label,
//     this.height = 65,
//     this.weight,
//     this.onTap,
//     this.isBusy = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: MaterialButton(
//         onPressed: onTap,
//         minWidth: MediaQuery.of(context).size.width,
//         disabledColor: AppColors.primary.withOpacity(0.5),
//         color: AppColors.primary,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//         ),
//         child: Container(
//           height: height,
//           alignment: Alignment.center,
//           child: Visibility(
//             visible: !isBusy,
//             replacement: const SizedBox.square(
//               child: FittedBox(
//                 child: AppLoader(
//                   padding: 0,
//                   size: 25,
//                   color: AppColors.black,
//                 ),
//               ),
//             ),
//             child: Text(
//               label,
//               style: AppTextStyles.medium20.copyWith(
//                 color: AppColors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
