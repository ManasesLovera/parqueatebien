import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend_android_ciudadano/repositories/vehicle_repository.dart';
import 'package:frontend_android_ciudadano/models/car_model.dart';
import 'package:frontend_android_ciudadano/usecases/fetch_vehicle_details.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  group('FetchVehicleDetails', () {
    final mockRepository = MockVehicleRepository();
    final useCase = FetchVehicleDetails(repository: mockRepository);

    test('calls fetchVehicleDetails on the repository', () async {
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

      final result = await useCase.execute('A123489');

      verify(mockRepository.fetchVehicleDetails('A123489')).called(1);
      expect(result, car);
    });
  });
}
