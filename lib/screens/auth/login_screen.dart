import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/auth/auth_controller.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/screens/auth/reset/forgot_password_screen.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class LoginScreen extends HookConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final pendinglogin = useState<Future<void>?>(null);
    final isLoading = useFuture(pendinglogin.value).connectionState ==
        ConnectionState.waiting;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ZeelBackButton(),
        ),
      ),
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ZeelTitleText(
                        text: "Welcome Back!",
                      ),

                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text: "Log in to your account to manage your finance",
                      ),
                      const SizedBox(height: 50.0),
                      const ZeelTextFieldTitle(text: "Email Address"),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZeelTextField(
                              enabled: true,
                              validator: emailValidator,
                              controller: emailController,
                              hint: "Enter your email",
                            ),
                            const ZeelTextFieldTitle(text: "Password"),
                            PassWordFormField(controller: passwordController),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                  isLoading: isLoading,
                                  onPressed: () {
                                    final future = ref
                                        .read(authControllerProvider.notifier)
                                        .login(
                                            ref: ref,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            formkey: formKey,
                                            context: context);
                                    pendinglogin.value = future;
                                  }),
                              const SizedBox(height: 10.0),
                              TextButton(
                                  onPressed: () {
                                    Go.to(ForgotPasswordScreen());
                                  },
                                  child: Text("Forgot Password? Change it!",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
