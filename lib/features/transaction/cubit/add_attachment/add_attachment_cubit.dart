import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_attachment_state.dart';

@injectable
class AddAttachmentCubit extends Cubit<AddAttachmentState> {
  AddAttachmentCubit() : super(AddAttachmentInitial());

  XFile? image;

  void setImage({required XFile selectedImage}) {
    image = selectedImage;

    emit(SelectedAttachment(selectedImage: selectedImage));
  }
}
