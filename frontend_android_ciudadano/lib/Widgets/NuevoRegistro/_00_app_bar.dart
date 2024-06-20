import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarRegister extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Nuevo Registro',
        style: TextStyle(color: Colors.blue),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: SizedBox(
            height: 35.h, child: SvgPicture.asset('assets/icons/back.svg')),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
