import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend_android_ciudadano/repositories/vehicle_repository.dart';
import 'package:frontend_android_ciudadano/models/car_model.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  group('VehicleRepository', () {
    final mockRepository = MockVehicleRepository();

    test(
        'fetchVehicleDetails returns a Car if the repository call completes successfully',
        () async {
      const car = CarModel(
        licensePlate: 'A123489',
        status: 'Reportado',
        vehicleType: 'Motor',
        vehicleColor: 'Azul',
        currentAddress: 'Santiago',
        reportedDate: '2024-06-18T20:15:00',
        arrivalAtParkingLot: '',
        photos: [],
      );

      when(mockRepository.fetchVehicleDetails('A123489'))
          .thenAnswer((_) async => car);

      final result = await mockRepository.fetchVehicleDetails('A123489');

      verify(mockRepository.fetchVehicleDetails('A123489')).called(1);
      expect(result, car);
    });

    test(
        'fetchVehicleDetails throws an exception if the repository call completes with an error',
        () async {
      when(mockRepository.fetchVehicleDetails('A123490'))
          .thenThrow(Exception('Failed to fetch vehicle details'));

      expect(() async => await mockRepository.fetchVehicleDetails('A123490'),
          throwsException);
    });
  });
}
