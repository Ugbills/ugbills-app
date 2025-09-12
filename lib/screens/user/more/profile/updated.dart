// import 'package:flutter/material.dart';
// import 'package:ugbills/screens/onboarding/onboarding.dart';
// import 'package:ugbills/screens/user/user.dart';
// import 'package:ugbills/themes/palette.dart';

// class ProfileUpdated extends StatelessWidget {
//   const ProfileUpdated({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Spacer(),
//             Image.asset("assets/images/sent.png"),
//             const Text(
//               "Updated",
//               style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: ZealPalette.primaryBlue),
//             ),
//             const Text(
//               "You have successfully updated your email address.",
//               style: TextStyle(color: Colors.grey),
//             ),
//             const Spacer(flex: 3),
//             ZeelButton(
//               text: "Back",
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (_) => const UserScreen()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
