import 'package:flutter/foundation.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class FailureHandler {
  FailureHandler._();
  static FailureHandler instance = FailureHandler._();

  final _logger = Logger();
  static const _id = AppKeys.sentryId;

  /// Initialize the error catcher
  Future<void> initialize() async {
    final sentry = SentryClient(SentryOptions(dsn: _id));

    FlutterError.onError = (details) {
      if (!kReleaseMode) {
        return FlutterError.dumpErrorToConsole(details, forceReport: true);
      }
      sentry.captureException(details.exception, stackTrace: details.stack);
    };
    await SentryFlutter.init(
      (options) {
        options.dsn = _id;
        options.tracesSampleRate = 1.0;
      },
    );

    _logger.d('Error Catcher initialized');
  }

  /// Sets user data [email] so it can be known from the console
  ///
  /// When [email] is null, the user is deleted from sentry console
  void setUser([String? email]) {
    if (kReleaseMode) {
      Sentry.configureScope((scope) {
        scope.setUser(
          email == null ? null : SentryUser(email: email),
        );
      });
    }
  }

  /// Method to catch errors.
  ///
  /// It takes in the error, the stacktrace and optionally a message.
  Future<void> catchError(error,
      {StackTrace? stackTrace, String? message}) async {
    if (!kReleaseMode) {
      return FlutterError.dumpErrorToConsole(
        FlutterErrorDetails(exception: error, stack: stackTrace),
        forceReport: true,
      );
    }
    try {
      final program = LoggerStackTrace.from(StackTrace.current);
      await Sentry.captureEvent(
        SentryEvent(
          eventId: SentryId.newId(),
          level: SentryLevel.error,
          throwable: error,
          message: message != null ? SentryMessage(message) : null,
          extra: {
            "Debug Info": {
              'callerFunctionName': program.callerFunctionName,
              'fileName': program.fileName,
              'lineNumber': program.lineNumber,
            }
          },
        ),
        stackTrace: stackTrace,
      );
      _logger.d("Error Caught");
    } catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      if (kReleaseMode) await Sentry.captureException(e, stackTrace: s);
    }
  }

  /// Method to catch messages.
  /// Messages in this project refers to data logged to the console that
  /// are not fatal
  ///
  /// It takes in a message, optionally extra data and the stacktrace.
  Future<void> catchMessage(
    String message, {
    Map<String, dynamic> extraData = const {},
    StackTrace? stackTrace,
  }) async {
    if (!kReleaseMode) return;
    try {
      final program = LoggerStackTrace.from(StackTrace.current);
      await Sentry.captureEvent(
        SentryEvent(
          eventId: SentryId.newId(),
          level: SentryLevel.info,
          message: SentryMessage(message),
          extra: {
            "Debug Info": {
              'callerFunctionName': program.callerFunctionName,
              'fileName': program.fileName,
              'lineNumber': program.lineNumber,
            },
            ...extraData,
          },
        ),
        stackTrace: stackTrace,
      );
      _logger.i("Message Caught");
    } catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      if (kReleaseMode) await Sentry.captureException(e, stackTrace: s);
    }
  }
}

class LoggerStackTrace {
  const LoggerStackTrace._({
    required this.functionName,
    required this.callerFunctionName,
    required this.fileName,
    required this.lineNumber,
    required this.columnNumber,
  });

  factory LoggerStackTrace.from(StackTrace trace) {
    final frames = trace.toString().split('\n');
    final functionName = _getFunctionNameFromFrame(frames[0]);
    final callerFunctionName = _getFunctionNameFromFrame(frames[1]);
    final fileInfo = _getFileInfoFromFrame(frames[1]);
    Sentry.addBreadcrumb(Breadcrumb(message: fileInfo.toString()));
    return LoggerStackTrace._(
      functionName: functionName,
      callerFunctionName: callerFunctionName,
      fileName: fileInfo[0],
      lineNumber: int.parse(fileInfo[1].replaceFirst(')', '')),
      columnNumber: int.parse(fileInfo.last.replaceFirst(')', '')),
    );
  }

  final String functionName;
  final String callerFunctionName;
  final String fileName;
  final int lineNumber;
  final int columnNumber;

  static List<String> _getFileInfoFromFrame(String trace) {
    final indexOfFileName = trace.indexOf(RegExp('[A-Za-z_-]+.dart'));
    final fileInfo = trace.substring(indexOfFileName);

    return fileInfo.split(':');
  }

  static String _getFunctionNameFromFrame(String trace) {
    final indexOfWhiteSpace = trace.indexOf(' ');
    final subStr = trace.substring(indexOfWhiteSpace);
    final indexOfFunction = subStr.indexOf(RegExp('[A-Za-z0-9]'));

    return subStr
        .substring(indexOfFunction)
        .substring(0, subStr.substring(indexOfFunction).indexOf(' '));
  }

  @override
  String toString() {
    return 'LoggerStackTrace('
        'functionName: $functionName, '
        'callerFunctionName: $callerFunctionName, '
        'fileName: $fileName, '
        'lineNumber: $lineNumber, '
        'columnNumber: $columnNumber)';
  }
}
