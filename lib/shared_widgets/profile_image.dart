import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_management_app/dummy_data.dart';

Container profileImage({
  required BuildContext context,
  required String imageUrl,
  String? imageFromFilePath,
  double radius = 80,
}) {
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    ),
    child: ClipOval(
      child: imageFromFilePath != null
          ? Image.file(
              File(imageFromFilePath),
              fit: BoxFit.cover,
              width: radius,
              height: radius,
            )
          : Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: radius,
              height: radius,
              errorBuilder: (context, error, stackTrace) {
                // Display dummy image on error
                return Image.network(
                  dummyImage,
                  fit: BoxFit.cover,
                  width: radius,
                  height: radius,
                );
              },
            ),
    ),
  );
}
