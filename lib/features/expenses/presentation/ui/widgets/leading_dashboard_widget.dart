// import 'package:budget_in/core/core.dart';
// import 'package:budget_in/features/authentication/authentication.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class LeadingDashboardWidget extends StatelessWidget {
//   const LeadingDashboardWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: ColorApp.green,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(15),
//           bottomRight: Radius.circular(15),
//         ),
//       ),
//       flexibleSpace: Container(
//         height: 75,
//         margin: const EdgeInsets.only(
//           left: 24,
//           right: 24,
//           top: 35,
//           bottom: 5,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'User name',
//                   style: context.textTheme.bodySmall?.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Rp. ',
//                         style: context.textTheme.bodySmall?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                       TextSpan(
//                         text: '2.000.000',
//                         style: context.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             // InkWell(
//             //   onTap: () => Navigator.pushNamed(
//             //     context,
//             //     ProfilePage.routeName,
//             //   ),
//             //   child: CircleAvatar(
//             //     radius: 30,
//             //     backgroundColor: ColorApp.grey,
//             //     child: SvgPicture.asset(
//             //       SvgName.profile,
//             //       width: 45,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
