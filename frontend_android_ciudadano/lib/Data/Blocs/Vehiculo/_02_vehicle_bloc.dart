import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_android_ciudadano/Api/ConsultaDePlacas/_00_api_consulta_placa.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_00_vehicle_event.dart';
import 'package:frontend_android_ciudadano/Data/Blocs/Vehiculo/_01_vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final ConsultaPlaca placaconsult;

  VehicleBloc(this.placaconsult) : super(VehicleInitial()) {
    on<FetchLicencePlates>((event, emit) async {
      emit(VehicleLoading());
      try {
        final licencePlates = await placaconsult.fetchLicencePlates();
        emit(VehicleLoaded(licencePlates));
      } catch (e) {
        emit(VehicleError(e.toString()));
      }
    });
  }
}
