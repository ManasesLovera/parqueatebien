String? plateValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese un número de placa';
  }
  if (!RegExp(r'^[A-Z][0-9]{6}$').hasMatch(value)) {
    return 'La placa debe empezar con una letra mayúscula seguida de 6 números';
  }
  return null;
}

String? vehicleTypeValidator(String? value) {
  if (value == null) {
    return 'Seleccione un tipo de vehículo';
  }
  return null;
}

String? colorValidator(String? value) {
  if (value == null) {
    return 'Seleccione un color';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese una dirección';
  }
  return null;
}
