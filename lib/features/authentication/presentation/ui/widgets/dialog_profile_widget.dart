// import 'package:budget_in/core/core.dart';
// import 'package:budget_in/features/authentication/presentation/ui/pages/edit_profile_page.dart';
// import 'package:flutter/material.dart';

// class DialogProfileWidget extends StatelessWidget {
//   const DialogProfileWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: Column(
//         children: [
//           const SizedBox(height: 15),
//           IconTextWidget(
//             onTap: () async {
//               Navigator.pop(context);
//               await Navigator.pushNamed(context, EditProfilePage.routeName);
//             },
//             image: SvgName.person,
//             title: Strings.editProfile,
//           ),
//           const SizedBox(height: 15),
//           IconTextWidget(
//             onTap: () {},
//             image: SvgName.delete,
//             title: Strings.deleteAccount,
//           ),
//         ],
//       ),
//     );
//   }
// }
