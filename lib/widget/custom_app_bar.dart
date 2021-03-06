import 'package:appointments/providers/app_data.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/app_bar_painter.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final CustomAppBarProps customAppBarProps;
  const CustomAppBar({
    Key? key,
    required this.customAppBarProps,
  }) : super(key: key);

  @override
  Size get preferredSize => Device.get().isIphoneX
      ? Size.fromHeight(rSize(customAppBarProps.barHeight))
      : Size.fromHeight(rSize(customAppBarProps.barHeight));

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  double rippleStartX = 0;
  double rippleStartY = 0;
  late AnimationController _controller;
  late Animation _animation;
  bool isInSearchMode = false;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        isInSearchMode = true;
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });
    _controller.forward();
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });
    onSearchQueryChange('');
    _controller.reverse();
  }

  onSearchQueryChange(String query) {
    final appData = Provider.of<AppData>(context, listen: false);
    appData.getFiltered(query);
  }

  @override
  Widget build(BuildContext context) {
    getActions() {
      double actionWidth = 0;
      if (widget.customAppBarProps.withBack &&
          (widget.customAppBarProps.customIcon == null &&
              !widget.customAppBarProps.withSearch &&
              !widget.customAppBarProps.withSave)) {
        actionWidth += 50;
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.customAppBarProps.withSave
              ? EaseInAnimation(
                  onTap: widget.customAppBarProps.saveTap ?? () => {},
                  child: Container(
                    margin: EdgeInsets.only(
                      right: rSize(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: rSize(12),
                      vertical: rSize(10),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          rSize(10),
                        )),
                    child: Text(
                      'Save'.toUpperCase(),
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                )
              : Container(),
          widget.customAppBarProps.withSearch
              ? GestureDetector(
                  onTapUp: onSearchTapUp,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: IconTheme(
                          data: Theme.of(context).primaryIconTheme,
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          widget.customAppBarProps.customIcon != null
              ? EaseInAnimation(
                  onTap: widget.customAppBarProps.customIconTap ?? () => {},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                    child: CustomIcon(
                        customIconProps: CustomIconProps(
                      icon: IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child:
                            widget.customAppBarProps.customIcon ?? Container(),
                      ),
                    )),
                  ),
                )
              : Container(),
          SizedBox(
            width: actionWidth,
          )
        ],
      );
    }

    getLeadingIcon() {
      double actionsWidth = 0;
      if (widget.customAppBarProps.withSearch) {
        actionsWidth += 50;
      }
      if (widget.customAppBarProps.customIcon != null) {
        actionsWidth += 50;
      }
      if (widget.customAppBarProps.withSave) {
        actionsWidth += 50;
      }
      if (widget.customAppBarProps.withBack &&
          (widget.customAppBarProps.customIcon != null ||
              widget.customAppBarProps.withSearch ||
              widget.customAppBarProps.withSave)) {
        actionsWidth -= 50;
      }
      return widget.customAppBarProps.withBack
          ? Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(rSize(15), 0, 0, 0),
                  child: EaseInAnimation(
                    onTap: () => Navigator.pop(context),
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: IconTheme(
                          data: Theme.of(context).primaryIconTheme,
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: rSize(actionsWidth),
                ),
              ],
            )
          : SizedBox(
              width: rSize(actionsWidth),
            );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: widget.customAppBarProps.withClipPath
          ? _AppBarClipper(
              childHeight: 10,
              isBig: false,
            )
          : null,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shadowColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                height: widget.customAppBarProps.withBorder ? rSize(1) : 0,
              ),
            ),
            titleSpacing: 0,
            leading: const SizedBox(
              width: 0,
              height: 0,
            ),
            leadingWidth: 0,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  getLeadingIcon(),
                  Expanded(
                    child: Wrap(
                      alignment: widget.customAppBarProps.centerTitle,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        widget.customAppBarProps.titleWidget ??
                            Text(
                              widget.customAppBarProps.titleText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                      ],
                    ),
                  )
                ]),
            actions: [
              getActions(),
            ],
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: AppBarPainter(
                  containerHeight: rSize(widget.customAppBarProps.barHeight),
                  center: Offset(rippleStartX, rippleStartY),
                  radius: _animation.value * screenWidth,
                  context: context,
                ),
              );
            },
          ),
          isInSearchMode
              ? (SearchBar(
                  barHeight: widget.customAppBarProps.barHeight,
                  onCancelSearch: cancelSearch,
                  onSearchQueryChanged: onSearchQueryChange,
                ))
              : (Container())
        ],
      ),
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  final bool isBig;
  final double childHeight;

  _AppBarClipper({
    required this.isBig,
    required this.childHeight,
  });

  @override
  Path getClip(Size size) {
    double height = isBig ? size.height - rSize(childHeight) : size.height;
    Path path = Path();

    path.moveTo(0, height - rSize(40));
    path.quadraticBezierTo(
        size.width / 2, height, size.width, height - rSize(40));
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CustomAppBarProps {
  final String titleText;
  final Widget? titleWidget;
  final WrapAlignment centerTitle;
  final Widget? customIcon;
  final VoidCallback? customIconTap;
  final bool withSearch;
  final bool withBack;
  final bool withSave;
  final VoidCallback? saveTap;
  final bool withClipPath;
  final bool withBorder;
  final double barHeight;
  CustomAppBarProps({
    this.titleText = 'Custom Title',
    this.titleWidget,
    this.barHeight = 65,
    this.centerTitle = WrapAlignment.center,
    this.customIcon,
    this.customIconTap,
    this.saveTap,
    this.withBack = false,
    this.withSave = false,
    this.withSearch = false,
    this.withClipPath = false,
    this.withBorder = false,
  });
}
