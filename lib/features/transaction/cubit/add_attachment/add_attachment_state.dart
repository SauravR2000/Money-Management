part of 'add_attachment_cubit.dart';

@immutable
sealed class AddAttachmentState {}

final class AddAttachmentInitial extends AddAttachmentState {}

final class SelectedAttachment extends AddAttachmentState {
  final XFile? selectedImage;
  final File? selectedPdf;

  SelectedAttachment({this.selectedImage, this.selectedPdf});
}
