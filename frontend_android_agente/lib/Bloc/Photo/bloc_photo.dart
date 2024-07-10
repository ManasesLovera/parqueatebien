// import 'package:frontend_android/Bloc/Photo/event_photo.dart';
// import 'package:image_picker/image_picker.dart';

// class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
//   final ImagePicker _picker = ImagePicker();

//   PhotoBloc() : super(PhotoInitial()) {
//     on<PhotoPickedEvent>(_onPhotoPicked);
//     on<PhotoRemovedEvent>(_onPhotoRemoved);
//   }

//   Future<void> _onPhotoPicked(
//       PhotoPickedEvent event, Emitter<PhotoState> emit) async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 50,
//       preferredCameraDevice: CameraDevice.rear,
//     );

//     if (image != null) {
//       emit(PhotoPickedSuccess(List.from(state.photos)..add(image)));
//     }
//   }

//   void _onPhotoRemoved(PhotoRemovedEvent event, Emitter<PhotoState> emit) {
//     emit(PhotoPickedSuccess(List.from(state.photos)..remove(event.photo)));
//   }
// }
