import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void show(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                   padding: EdgeInsets.all(16.r),
                child: Text('Seleccione el número de placa a consultar',
                    style: TextStyle(color: Colors.black ,fontSize: 12.5.h,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Placa',
                  style: TextStyle(color: Colors.blue, fontSize: 12.h),
                ),
              ),
              DropdownButtonFormField<String>(
                value: 'A8034464',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                items: <String>['A8034464', 'B2345678', 'C8765432']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width:  double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: const Text('Consultar'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
