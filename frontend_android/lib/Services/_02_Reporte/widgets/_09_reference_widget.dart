import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool touched;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function() onValidate;

  const AddressWidget({
    super.key,
    required this.controller,
    required this.touched,
    required this.focusNode,
    required this.onChanged,
     required this.onValidate,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.h),
                hintText: 'Ingresar',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10.h),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
          if (widget.touched && widget.controller.text.isEmpty)
            Text(
              'Por favor ingrese una dirección',
              style: TextStyle(color: Colors.red, fontSize: 10.h),
            ),
        ],
      ),
    );
  }
}
