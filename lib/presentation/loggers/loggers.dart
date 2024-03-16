import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Loggers extends StatelessWidget {
  const Loggers({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    var loggerNoStack = Logger(
      printer: PrettyPrinter(methodCount: 0),
    );
    logger.d('Log message with 2 methods');

    loggerNoStack.i('Info message');

    loggerNoStack.w('Just a warning!');

    logger.e('Error! Something bad happened', error: 'Test Error');

    loggerNoStack.t({'key': 5, 'value': 'something'});

    Logger(printer: SimplePrinter(colors: true)).t('boom');
    return  TopWidget(title: "logger",child: Container(),);
  }
}
