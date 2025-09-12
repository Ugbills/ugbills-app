// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shadcn_ui/shadcn_ui.dart';
// import 'package:short_navigation/short_navigation.dart';
// import 'package:ugbills/constants/assets/svg.dart';
// import 'package:ugbills/controllers/user/user_controller.dart';
// import 'package:ugbills/helpers/forms/validators.dart';
// import 'package:ugbills/helpers/storage/user.dart';
// import 'package:ugbills/providers/state/loading_state_provider.dart';
// import 'package:ugbills/repository/auth_repository.dart';
// import 'package:ugbills/screens/user/user.dart';
// import 'package:ugbills/screens/widgets/text_field_widgets.dart';
// import 'package:ugbills/screens/widgets/texts_widget.dart';
// import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
// import 'package:ugbills/services/auth_service.dart';

// class BiometricsLoginScreen extends ConsumerWidget {
//   BiometricsLoginScreen({super.key});

//   final TextEditingController pincontroller = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var isloading = ref.watch(isLoadingProvider);
//     return Scaffold(
//       appBar: AppBar(forceMaterialTransparency: true),
//       body: CustomScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const ZeelTitleText(
//                         text: "Hi, Omere",
//                       ),

//                       const SizedBox(height: 10.0),
//                       const ZeelText(
//                         text: "Log in to your account to manage your finance",
//                       ),
//                       const SizedBox(height: 50.0),
//                       const ZeelTextFieldTitle(
//                         text: "Security Pin",
//                       ),
//                       Form(
//                         key: formKey,
//                         child: PassWordFormField(
//                           controller: pincontroller,
//                           maxLength: 4,
//                           validator: securityPinValidator,
//                           keyboardType: TextInputType.number,
//                           hint: "Enter your security pin",
//                         ),
//                       ),
//                       const SizedBox(height: 50.0), // Add this line to the code
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ZeelButton(
//                               isLoading: isloading,
//                               onPressed: () {
//                                 if (formKey.currentState!.validate()) {
//                                   AuthRepository().loginWithPin(
//                                     context: context,
//                                     ref: ref,
//                                     pin: pincontroller.text,
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               var auth =
//                                   await LocalAuthService.authenticateUser();
//                               if (auth) {
//                                 Go.to(const UserScreen());
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Authentication failed.'),
//                                     duration: Duration(seconds: 2),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: const ShadImage(
//                               ZeelSvg.fingerprint,
//                               height: 57.0,
//                               width: 57.0,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 5.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Not you?",
//                               style: TextStyle(fontSize: 20)),
//                           TextButton(
//                               onPressed: () {
//                                 AuthRepository().logout();
//                               },
//                               child: Text("Switch account",
//                                   style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20))),
//                         ],
//                       ),
//                       isloading
//                           ? const SizedBox.shrink()
//                           : Expanded(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: TextButton(
//                                     onPressed: () {
//                                       ref
//                                           .read(isLoadingProvider.notifier)
//                                           .state = true;
//                                       UserController().sendResetOTP(
//                                           context: context,
//                                           ref: ref,
//                                           email: UserStorage().getEmail());
//                                     },
//                                     child: Text(
//                                         "Forgot Security Pin? Change it!",
//                                         style: TextStyle(
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20))),
//                               ),
//                             )
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ]),
//     );
//   }
// }
