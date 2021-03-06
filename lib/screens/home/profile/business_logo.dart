import 'dart:io';

import 'package:appointments/data_types/macros.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/image_picker_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class BusinessLogo extends StatefulWidget {
  const BusinessLogo({Key? key}) : super(key: key);

  @override
  State<BusinessLogo> createState() => _BusinessLogoState();
}

class _BusinessLogoState extends State<BusinessLogo> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    deleteLogo() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          footerButton: ModalFooter.both,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/trash.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: rSize(80),
                  contentPadding: rSize(20),
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Delete Logo?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Action can not be undone',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderBusinessLogo() {
      return AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 400),
        child: _imageFile == null
            ? EaseInAnimation(
                onTap: () => {
                  showImagePickerModal(
                    imagePickerModalProps: ImagePickerModalProps(
                      context: context,
                      cropStyle: CropStyle.circle,
                      saveImage: (File? imageFile) {
                        setState(() {
                          _imageFile = imageFile;
                        });
                      },
                    ),
                  )
                },
                beginAnimation: 0.98,
                child: DottedBorder(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  borderType: BorderType.Circle,
                  dashPattern: [rSize(6), rSize(4)],
                  strokeWidth: rSize(1),
                  radius: Radius.circular(
                    rSize(10),
                  ),
                  child: SizedBox(
                    width: rSize(160),
                    height: rSize(160),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomIcon(
                          customIconProps: CustomIconProps(
                            icon: null,
                            backgroundColor: Colors.transparent,
                            path: 'assets/icons/camera.png',
                            containerSize: 70,
                          ),
                        ),
                        SizedBox(
                          height: rSize(5),
                        ),
                        Text(
                          'Add Logo',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    width: rSize(160),
                    height: rSize(160),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rSize(80)),
                      image: DecorationImage(
                        image: FileImage(
                          _imageFile!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: rSize(40),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: rSize(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              onTap: () => {
                                showImagePickerModal(
                                  imagePickerModalProps: ImagePickerModalProps(
                                    context: context,
                                    cropStyle: CropStyle.circle,
                                    saveImage: (File? imageFile) {
                                      setState(() {
                                        _imageFile = imageFile;
                                      });
                                    },
                                  ),
                                )
                              },
                              text: 'Edit Logo',
                              isPrimary: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: rSize(40),
                        ),
                        Expanded(
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              onTap: () => {deleteLogo()},
                              text: 'Delete Logo',
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              textColor: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Logo',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageFile == null
                ? Column(
                    children: [
                      Text(
                        'Upload your business logo so its visible on your profile.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: rSize(100),
                      ),
                    ],
                  )
                : SizedBox(
                    height: rSize(40),
                  ),
            renderBusinessLogo(),
          ],
        ),
      ),
    );
  }
}
