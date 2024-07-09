import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Handlers/Login/sign_handler.dart';
import 'package:frontend_android/Widgets/Login/login_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _iD = TextEditingController();
  final _pass = TextEditingController();
  final String role = 'Agente';

  final ValueNotifier<bool> _isFilled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _iD.addListener(_updateButtonState);
    _pass.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    _isFilled.value = _iD.text.isNotEmpty && _pass.text.isNotEmpty;
  }

  @override
  void dispose() {
    _iD.removeListener(_updateButtonState);
    _pass.removeListener(_updateButtonState);
    _iD.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 157, 210),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                const LoginWidgets(),
                SizedBox(height: 50.h),
                const Usertext(),
                GovernmentIDTextField(controller: _iD),
                SizedBox(height: 20.h),
                const Passwordtext(),
                PasswordTextField(controller: _pass),
                SizedBox(height: 16.h),
                ValueListenableBuilder<bool>(
                  valueListenable: _isFilled,
                  builder: (context, isFilled, child) {
                    return SignInButton(
                      onPressed: isFilled
                          ? () => sign(context, _iD, _pass, role)
                          : null,
                      isFilled: isFilled,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                const ForgotPasswordText(),
                SizedBox(height: 140.h),
                const BottomImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
