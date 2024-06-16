import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android/Services/_02_Reporte/handlers/form_handlers.dart';
import 'package:frontend_android/Services/_02_Reporte/widgets/_11_siguientetext.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required FormHandlers formHandlers,
    required VoidCallback onValidate,
  })  : _formHandlers = formHandlers,
        _onValidate = onValidate;

  final FormHandlers _formHandlers;
  final VoidCallback _onValidate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 14.w),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _formHandlers.isFormValid ? Colors.blue : Colors.grey[400]!,
                _formHandlers.isFormValid
                    ? Colors.blueAccent
                    : Colors.grey[600]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ElevatedButton(
            onPressed: () {
              _onValidate();
              if (_formHandlers.isFormValid) {
                _formHandlers.validateOnSubmit(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
            ),
            child: const SiguienteText(),
          ),
        ),
      ),
    );
  }
}
