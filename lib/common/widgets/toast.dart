import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {
  static void success(String message) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      pauseOnHover: true,
    );
  }

  static void error(String message) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      pauseOnHover: true,
    );
  }

  static void info(String message) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      pauseOnHover: true,
    );
  }

  // static Widget _buildToastContent(String message, IconData icon) {
  //   return Row(
  //     children: [
  //       Icon(
  //         icon,
  //         color: AppThemeColors.toast().foreground,
  //         size: 24,
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       Expanded(
  //         child: Text(
  //           message,
  //           style: TextStyle(
  //             color: AppThemeColors.toast().foreground,
  //             fontSize: FontSize.m.value,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
