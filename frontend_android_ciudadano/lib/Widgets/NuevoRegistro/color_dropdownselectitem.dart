import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String? hintText;
  final Color dropdownBackgroundColor;

  const ColorDropdown({
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.hintText,
    super.key, required this.dropdownBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedItem,
              hint: Text(
                hintText ?? '',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11.h,
                ),
              ),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              iconSize: 24.h,
              onChanged: onChanged,
              dropdownColor: dropdownBackgroundColor,
              items: items.map((String color) {
               
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(
                    color,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.h,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
