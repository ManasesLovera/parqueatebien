import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SatusButtom extends StatelessWidget {
  const SatusButtom({
    super.key,
    required this.details,
  });

  final Map<String, dynamic> details;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'Reportado':
        return Colors.grey;
      case 'Retenido':
        return Colors.red;
      case 'Liberado':
        return Colors.green;
      case 'Incautado por grua':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: _getStatusColor(details['Status']),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(details['Status'],
            style: TextStyle(color: Colors.white, fontSize: 10.h)),
      ),
    );
  }
}
