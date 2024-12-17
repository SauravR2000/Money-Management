import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/utils/constants/enums.dart';

part 'add_attachment_state.dart';

@injectable
class AddAttachmentCubit extends Cubit<AddAttachmentState> {
  AddAttachmentCubit() : super(AddAttachmentInitial());

  XFile? image;

  void setImage({required ImageCaptureType imageCaptureType}) async {
    final ImagePicker picker = ImagePicker();

    ImageSource imageSource = imageCaptureType == ImageCaptureType.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    final XFile? selectedImage = await picker.pickImage(source: imageSource);

    image = selectedImage;

    emit(SelectedAttachment(selectedImage: selectedImage));
  }

  void removeImage() {
    image = null;
    emit(SelectedAttachment(selectedImage: image));
  }
}
