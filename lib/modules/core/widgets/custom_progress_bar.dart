import 'package:flutter/material.dart';

class CustomProgressBar {
  final BuildContext context;

  CustomProgressBar(this.context);

  static bool progressbarStatus = false;

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const LoadingIndicator(),
        );
      },
    );
    progressbarStatus = true;
  }

  void hideLoadingIndicator() {
    if (progressbarStatus == true) {
      Navigator.of(context).pop();
      progressbarStatus = false;
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
