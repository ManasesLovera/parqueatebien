import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarRegister extends StatelessWidget implements PreferredSizeWidget {
  final double progress;

  const AppBarRegister({
    super.key,
    this.progress = 0.0, // Valor por defecto para el progreso
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'Nuevo Registro',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: SizedBox(
              height: 24.h, // Ajusta el tamaño aquí si es necesario
              child: SvgPicture.asset('assets/icons/back.svg'),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Stack(
          children: [
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Positioned(
              left: 0,
              child: Container(
                width: progress,
                height: 3,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 2); // Ajusta el tamaño preferido para incluir la línea
}
