import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Widgets/NuevoRegistro/show_year_picker_dialog.dart';

class YearPickerSelectItem extends StatefulWidget {
  final int initialYear;
  final ValueChanged<int?> onChanged;
  final Color dropdownBackgroundColor;

  const YearPickerSelectItem({
    required this.initialYear,
    required this.onChanged,
    super.key,
    required this.dropdownBackgroundColor,
  });

  @override
  _YearPickerSelectItemState createState() => _YearPickerSelectItemState();
}

class _YearPickerSelectItemState extends State<YearPickerSelectItem> {
  int? selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear =
        widget.initialYear == DateTime.now().year ? null : widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showYearPickerDialog(
          context: context,
          initialYear: selectedYear ?? DateTime.now().year,
          onChanged: (year) {
            setState(() {
              selectedYear = year;
            });
            widget.onChanged(year);
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.w),
        child: Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
            color: widget.dropdownBackgroundColor,
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            child: Row(
              children: [
                Text(
                  selectedYear?.toString() ?? 'Seleccionar año',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
