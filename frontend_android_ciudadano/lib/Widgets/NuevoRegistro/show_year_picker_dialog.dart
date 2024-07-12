import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showYearPickerDialog({
  required BuildContext context,
  required int initialYear,
  required ValueChanged<int?> onChanged,
}) async {
  final int currentYear = DateTime.now().year;
  int selectedYear = initialYear;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return FadeTransitionDialog(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          title: Text('Seleccionar Año', style: TextStyle(fontSize: 12.h)),
          content: SizedBox(
            width: double.minPositive,
            height: 200.h,
            child: YearPicker(
              firstDate: DateTime(1900),
              lastDate: DateTime(currentYear),
              initialDate: DateTime(selectedYear),
              selectedDate: DateTime(selectedYear),
              onChanged: (DateTime dateTime) {
                selectedYear = dateTime.year;
                onChanged(selectedYear);
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    },
  );
}

class FadeTransitionDialog extends StatefulWidget {
  final Widget child;

  const FadeTransitionDialog({super.key, required this.child});

  @override
  _FadeTransitionDialogState createState() => _FadeTransitionDialogState();
}

class _FadeTransitionDialogState extends State<FadeTransitionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
