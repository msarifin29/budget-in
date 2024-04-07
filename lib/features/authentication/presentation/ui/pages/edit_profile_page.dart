// import 'package:budget_in/core/core.dart';
// import 'package:budget_in/features/authentication/authentication.dart';
// import 'package:budget_in/injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});
//   static const routeName = RouteName.editProfilePage;

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final nameControl = TextEditingController();
//   final inComeControl = TextEditingController();

//   final cityBloc = sl<CityBloc>();
//   final occupationBloc = sl<OccupationBloc>();

//   final initialCity = ValueNotifier<String?>('');
//   final initialOccupation = ValueNotifier<String?>('');

//   @override
//   void initState() {
//     cityBloc.add(const OnInitial());
//     occupationBloc.add(const OnInitialOccupation());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     nameControl.dispose();
//     inComeControl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => cityBloc,
//         ),
//         BlocProvider(
//           create: (context) => occupationBloc,
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Edit Profile',
//             style: context.textTheme.bodyLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               FormWidget(
//                 title: Strings.name,
//                 hint: '',
//                 controller: nameControl,
//               ),
//               const SizedBox(height: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     Strings.domicile,
//                     style: context.textTheme.bodyMedium
//                         ?.copyWith(fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 10),
//                   ValueListenableBuilder(
//                     valueListenable: initialCity,
//                     builder: (context, value, _) {
//                       return BlocBuilder<CityBloc, CityState>(
//                         builder: (context, state) {
//                           return DropdownButtonFormField(
//                             hint: Text(
//                               Strings.selectDomicile,
//                               style: context.textTheme.bodyMedium
//                                   ?.copyWith(fontWeight: FontWeight.w500),
//                             ),
//                             decoration: inputDecorationDropdownField(),
//                             focusColor: Colors.white,
//                             items: state.cities.map((v) {
//                               return DropdownMenuItem(
//                                 value: v,
//                                 child: Text(
//                                   v,
//                                   style: context.textTheme.bodyMedium?.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (newValue) {
//                               if (initialCity.value == null) return;
//                               initialCity.value = newValue;
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               FormWidget(
//                 title: '${Strings.income} ${Strings.monthly}',
//                 hint: '',
//                 controller: inComeControl,
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     'Rp.',
//                     style: context.textTheme.bodyLarge,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     Strings.occupation,
//                     style: context.textTheme.bodyMedium
//                         ?.copyWith(fontWeight: FontWeight.w500),
//                   ),
//                   const SizedBox(height: 10),
//                   ValueListenableBuilder(
//                     valueListenable: initialCity,
//                     builder: (context, value, _) {
//                       return BlocBuilder<OccupationBloc, OccupationState>(
//                         builder: (context, state) {
//                           return DropdownButtonFormField(
//                             hint: Text(
//                               Strings.selectOccupation,
//                               style: context.textTheme.bodyMedium
//                                   ?.copyWith(fontWeight: FontWeight.w500),
//                             ),
//                             decoration: inputDecorationDropdownField(),
//                             focusColor: Colors.white,
//                             items: state.occupations.map((v) {
//                               return DropdownMenuItem(
//                                 value: v,
//                                 child: Text(
//                                   v,
//                                   style: context.textTheme.bodyMedium?.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (newValue) {
//                               if (initialOccupation.value == null) return;
//                               initialOccupation.value = newValue;
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 100),
//               PrimaryButton(
//                 text: Strings.signIn,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
