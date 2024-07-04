import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_android_ciudadano/Data/Models/NuevoRegistro/Cars/car_model.dart';

class CustomDropdownSelectItem extends StatelessWidget {
  final List<Vehicle> items;
  final Vehicle? selectedItem;
  final ValueChanged<Vehicle?> onChanged;
  final String? hintText;

  const CustomDropdownSelectItem({
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.hintText,
    super.key,
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
            child: DropdownButton<Vehicle>(
              value: selectedItem,
              hint: Text(
                hintText ?? '',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.h,
                ),
              ),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              iconSize: 24.h,
              onChanged: onChanged,
              items: items.map((Vehicle carModel) {
                return DropdownMenuItem<Vehicle>(
                  value: carModel,
                  child: Text(
                    carModel.color,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.h,
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
