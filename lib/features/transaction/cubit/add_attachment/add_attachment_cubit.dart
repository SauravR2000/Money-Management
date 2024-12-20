import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:file_picker/file_picker.dart';

part 'add_attachment_state.dart';

@injectable
class AddAttachmentCubit extends Cubit<AddAttachmentState> {
  AddAttachmentCubit() : super(AddAttachmentInitial());

  XFile? image;
  File? pdf;

  void setImage({required ImageCaptureType imageCaptureType}) async {
    final ImagePicker picker = ImagePicker();

    ImageSource imageSource = imageCaptureType == ImageCaptureType.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    final XFile? selectedImage = await picker.pickImage(source: imageSource);

    image = selectedImage;

    emit(SelectedAttachment(selectedImage: selectedImage));
  }

  void setPdf() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);

    if (result != null) {
      File file = File(result.files.single.path!);
      pdf = file;

      emit(SelectedAttachment(selectedPdf: file));
    } else {
      // User canceled the picker
    }
  }

  void removeImage() {
    image = null;
    emit(SelectedAttachment(selectedImage: image));
  }

  void remotePdf() {
    pdf = null;
    emit(SelectedAttachment(selectedPdf: pdf));
  }
}
