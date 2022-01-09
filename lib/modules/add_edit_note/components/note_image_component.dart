import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visual_notes/core/components/image_pick_component.dart';
import 'package:visual_notes/core/styles/app_colors.dart';
import 'package:visual_notes/core/styles/app_images.dart';
import 'package:visual_notes/core/styles/sizes.dart';
import 'package:visual_notes/modules/add_edit_note/viewmodels/add_note_viewmodel.dart';

class NoteImageComponent extends StatelessWidget {
  const NoteImageComponent({
    required this.addNoteVM,
    Key? key,
  }) : super(key: key);

  final AddNoteViewModel addNoteVM;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: Sizes.noteImageHighRadius,
          backgroundImage: (addNoteVM.noteImage == null &&
                  addNoteVM.visualNoteModel?.image == null)
              ? const AssetImage(AppImages.placeHolderImage)
              : null,
          foregroundImage: addNoteVM.noteImage != null
              ? FileImage(addNoteVM.noteImage!)
              : addNoteVM.visualNoteModel != null
                  ? FileImage(File(addNoteVM.visualNoteModel!.image))
                  : null,
          backgroundColor: AppColors.primaryColor,
        ),
        Padding(
          padding: EdgeInsets.only(right: Sizes.hPaddingTiny),
          child: ImagePickComponent(
            pickFromCameraFunction: () {
              addNoteVM.pickNoteImage(fromCamera: true);
            },
            pickFromGalleryFunction: () {
              addNoteVM.pickNoteImage(fromCamera: false);
            },
          ),
        ),
      ],
    );
  }
}
