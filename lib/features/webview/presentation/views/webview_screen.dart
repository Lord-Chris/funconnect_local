import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/webview/presentation/blocs/webview_bloc/webview_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String link;
  const WebViewScreen({super.key, required this.link});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    context.read<WebviewBloc>().add(LoadUrlEvent(widget.link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<WebviewBloc, WebviewState>(
      builder: (context, state) {
        if (state is WebviewLoaded) {
          return WebViewWidget(
            controller: state.controller,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
