import 'package:flutter/material.dart';

enum App {
  fileExplorer,
  gallery,
  ;


  Widget get icon {
    switch (this) {
      case App.fileExplorer:
        return const Icon(Icons.folder);
      case App.gallery:
        return const Icon(Icons.photo);

    }
  }
}