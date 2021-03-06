import 'package:appointments/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../utils/layout.dart';

void showBottomModal({
  required BottomModalProps bottomModalProps,
}) {
  Widget renderFooterModal(BuildContext context) {
    if (bottomModalProps.footerButton == ModalFooter.both) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomButton(
              customButtonProps: CustomButtonProps(
                  onTap: () => {Navigator.pop(context)},
                  text: bottomModalProps.secondaryButtonText,
                  isPrimary: false,
                  isSecondary: true,
                  beginAnimation: 0.95),
            ),
            CustomButton(
                customButtonProps: CustomButtonProps(
              onTap: () => {
                Navigator.pop(context),
                bottomModalProps.primaryAction != null
                    ? bottomModalProps.primaryAction!()
                    : () => {},
              },
              beginAnimation: 0.95,
              text: bottomModalProps.primaryButtonText,
              borderColor: bottomModalProps.deleteCancelModal
                  ? Theme.of(context).colorScheme.error
                  : null,
              textColor: bottomModalProps.deleteCancelModal
                  ? Theme.of(context).colorScheme.error
                  : null,
              backgroundColor: bottomModalProps.deleteCancelModal
                  ? Colors.transparent
                  : null,
              isPrimary: true,
              isSecondary: false,
            )),
          ]);
    }
    if (bottomModalProps.footerButton == ModalFooter.primaryButton) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomButton(
                customButtonProps: CustomButtonProps(
              onTap: () => {Navigator.pop(context)},
              beginAnimation: 0.95,
              text: bottomModalProps.primaryButtonText,
              isPrimary: true,
            )),
          ]);
    }
    if (bottomModalProps.footerButton == ModalFooter.secondaryButton) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {Navigator.pop(context)},
                beginAnimation: 0.95,
                text: bottomModalProps.secondaryButtonText,
                isSecondary: true,
              ),
            ),
          ]);
    }
    return const SizedBox();
  }

  showCupertinoModalBottomSheet(
    backgroundColor: Theme.of(bottomModalProps.context).colorScheme.background,
    bounce: false,
    duration: bottomModalProps.duration,
    isDismissible: bottomModalProps.isDismissible,
    // animationCurve: Curves.easeIn,
    // barrierColor:
    //     Theme.of(bottomModalProps.context).colorScheme.primary.withOpacity(0.2),
    enableDrag: bottomModalProps.enableDrag,
    topRadius: Radius.circular(rSize(40)),
    context: bottomModalProps.context,
    builder: (context) => Stack(
      alignment: Alignment.center,
      children: [
        SafeArea(
          left: false,
          right: false,
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              bottomModalProps.title.isNotEmpty
                  ? Container(
                      alignment: bottomModalProps.centerTitle
                          ? Alignment.center
                          : Alignment.centerLeft,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                          rSize(30),
                          bottomModalProps.showDragPen ? rSize(30) : rSize(15),
                          rSize(30),
                          rSize(15)),
                      child: Text(
                        bottomModalProps.title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: EdgeInsets.all(rSize(25)),
                child: bottomModalProps.child,
                // child: Flexible(
                //   child: bottomModalProps.child,
                //   fit: FlexFit.tight,
                // ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(25),
                ),
                child: renderFooterModal(context),
              )
            ],
          ),
        ),
        Positioned(
          top: rSize(10),
          child: bottomModalProps.showDragPen
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
                  width: rSize(40),
                  height: rSize(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(rSize(10))),
                )
              : const SizedBox(),
        ),
      ],
    ),
  );
}

class BottomModalProps {
  BuildContext context;
  Widget child;
  bool isDismissible;
  bool deleteCancelModal;
  bool enableDrag;
  bool showDragPen;
  ModalFooter footerButton;
  String title;
  String primaryButtonText;
  String secondaryButtonText;
  bool centerTitle;
  Duration duration;
  Function? primaryAction;

  BottomModalProps({
    required this.context,
    required this.child,
    this.isDismissible = true,
    this.enableDrag = false,
    this.showDragPen = false,
    this.deleteCancelModal = false,
    this.title = '',
    this.primaryButtonText = 'primary',
    this.secondaryButtonText = 'secondary',
    this.centerTitle = false,
    this.duration = const Duration(milliseconds: 350),
    this.footerButton = ModalFooter.none,
    this.primaryAction,
  });
}

enum ModalFooter {
  primaryButton,
  secondaryButton,
  both,
  none,
}
