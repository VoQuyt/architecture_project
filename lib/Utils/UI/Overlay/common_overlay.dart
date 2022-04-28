part of lib_ui;

class CommonOverlay {
  static OverlayEntry? _overlay;
  static _CommonOverlay? _decloOverlay;
  static void show(int statusCode) {
    if (_overlay != null) {
      return;
    }
    _decloOverlay = _CommonOverlay(statusCode: statusCode);
    _overlay = OverlayEntry(builder: (BuildContext context) => _decloOverlay!);
    Navigator.of(Navigation.rootContext).overlay!.insert(_overlay!);
  }

  static void hide([void Function()? completion]) {
    try {
      _decloOverlay?.hide(() {
        _overlay?.remove();
        _overlay = null;
        _decloOverlay = null;
        if (completion != null) {
          completion();
        }
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

class _CommonOverlay extends StatefulWidget {
  final int statusCode;
  _CommonOverlay({Key? key, required this.statusCode}) : super(key: key);
  final __CommonOverlayState myAppState = __CommonOverlayState();

  @override
  __CommonOverlayState createState() => myAppState;
  hide(Function completion) {
    myAppState.hide();
  }
}

class __CommonOverlayState extends State<_CommonOverlay> {
  final bool _visible = true;

  hide() {
    CommonOverlay._overlay?.remove();
    CommonOverlay._overlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: _buildErrorWidget()
    );
  }

  _buildErrorWidget() {
    switch (widget.statusCode) {
      case 500:
        return Container();
      case 503:
        return Container();
      default:
    }
  }
}