import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rolling_switch/rolling_switch.dart';

class DayDetails extends StatefulWidget {
  final String dayTile;
  const DayDetails({
    Key? key,
    this.dayTile = '',
  }) : super(key: key);

  @override
  State<DayDetails> createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  DateTime? durationValue;
  bool isWorking = false;
  @override
  Widget build(BuildContext context) {
    Widget _renderSwitch() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Transform.scale(
            scale: 0.7,
            child: RollingSwitch.widget(
              innerSize: rSize(50),
              width: rSize(160),
              height: rSize(60),
              circularColor: Theme.of(context).colorScheme.background,
              initialState: isWorking,
              onChanged: (bool state) {
                setState(() {
                  isWorking = state;
                });
              },
              rollingInfoRight: RollingWidgetInfo(
                icon: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/check.png',
                    containerSize: 30,
                  ),
                ),
                text: Text(
                  'Open',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              rollingInfoLeft: RollingWidgetInfo(
                icon: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/close.png',
                    containerSize: 30,
                  ),
                ),
                text: Text(
                  'Closed',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      );
    }

    Widget _renderBreaks() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Breaks',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(20),
          ),
          CustomTextButton(
            customTextButtonProps: CustomTextButtonProps(
              text: 'Add Break',
              textColor: Theme.of(context).colorScheme.primary,
              fontSize: rSize(18),
              withIcon: true,
              icon: Icon(
                FontAwesomeIcons.plus,
                size: rSize(18),
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => {},
            ),
          ),
        ],
      );
    }

    Widget _renderTimePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Start',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  height: rSize(5),
                ),
                CustomInputFieldButton(
                  text: getDateTimeFormat(
                    dateTime: durationValue,
                    format: 'HH:mm',
                  ),
                  onTap: () => showPickerTimeRangeModal(
                    pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                      context: context,
                      title: 'Start Time',
                      startTimeValue: durationValue,
                      pickerTimeRangType: PickerTimeRangType.single,
                      primaryAction: (DateTime x) => setState(() {
                        durationValue = x;
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'End',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
                SizedBox(
                  height: rSize(5),
                ),
                CustomInputFieldButton(
                  text: getDateTimeFormat(
                    dateTime: durationValue,
                    format: 'HH:mm',
                  ),
                  onTap: () => showPickerTimeRangeModal(
                    pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                      context: context,
                      title: 'End Time',
                      startTimeValue: durationValue,
                      pickerTimeRangType: PickerTimeRangType.single,
                      primaryAction: (DateTime x) => setState(() {
                        durationValue = x;
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: widget.dayTile,
          withBack: true,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderSwitch(),
              SizedBox(
                height: rSize(20),
              ),
              Text(
                'Set your business hours here. Head to Opening Calendar from Settings menu if you need to adjust hours for single day',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(14),
                    ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  reverseDuration: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 400),
                  child: isWorking
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: rSize(40),
                            ),
                            _renderTimePicker(),
                            SizedBox(
                              height: rSize(40),
                            ),
                            _renderBreaks(),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  text: 'OK',
                  onTap: (() => Navigator.pop(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}