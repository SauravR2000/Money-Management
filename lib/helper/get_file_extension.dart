import 'package:image_picker/image_picker.dart';

String getFileExtension({required XFile xfile}) {
  return xfile.path.split('.').last.toLowerCase();
}
