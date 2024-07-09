import 'package:flutter/material.dart';

void showUniversalSuccessErrorDialog(
    BuildContext context, String message, bool isSuccess) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds:2), () {
        Navigator.of(context).pop(true);
      });

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
