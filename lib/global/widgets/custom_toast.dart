import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastPosition { top, center, bottom }

extension ToastExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  void showToast({
    required String message,
    Color? textColor,
    Color? backgroundColor,
    int toastDurationInSeconds = 5,
    double? height,
    double? customPostionTop,
    ToastPosition position = ToastPosition.top,
  }) {
    FToast fToast = FToast();
    fToast.init(this);
    fToast.showToast(
      child: Container(
        padding:
            const EdgeInsets.only(left: 16.0, right: 20, top: 10, bottom: 10),
        width: MediaQuery.of(this).size.width * 0.85,
        height: height ?? screenHeight * 0.061,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor ?? const Color(0XFFF1F4FE),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 0.5,
              color: Color.fromARGB(31, 88, 88, 88),
            )
          ],
        ),
        child: SizedBox(
          width: screenWidth * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/info.svg',
                      height: 18,
                      width: 18,
                      color: textColor ?? const Color(0xff122D97),
                      colorFilter: textColor != null
                          ? ColorFilter.mode(
                              textColor,
                              BlendMode.srcIn,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                        child: Text(
                      message,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor ?? const Color(0xff122D97)),
                    )),
                  ],
                ),
              ),
              InkWell(
                onTap: (() {
                  fToast.removeCustomToast();
                }),
                child: Row(
                  children: [
                    Container(
                      width: 1,
                      height: double.infinity,
                      color:
                          textColor ?? const Color(0xff122D97).withOpacity(0.8),
                    ),
                    const SizedBox(width: 16.0),
                    SvgPicture.asset(
                      'assets/cancel_icon.svg',
                      height: 13,
                      width: 13,
                      colorFilter: ColorFilter.mode(
                        textColor ?? const Color(0xff122D97),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      positionedToastBuilder: (context, child) {
        switch (position) {
          case ToastPosition.top:
            return Positioned(
              top: customPostionTop ?? 60,
              left: 24.0,
              right: 24.0,
              child: child,
            );
          case ToastPosition.center:
            return Positioned(
              top: screenHeight * 0.5,
              left: 24.0,
              right: 24.0,
              child: child,
            );
          case ToastPosition.bottom:
            return Positioned(
              bottom: screenHeight * 0.1,
              left: 24.0,
              right: 24.0,
              child: child,
            );
        }
      },
      toastDuration: Duration(seconds: toastDurationInSeconds),
    );
  }
}
