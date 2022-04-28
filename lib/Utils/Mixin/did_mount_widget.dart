part of lib_mixin;

mixin WidgetDidMount<T extends StatefulWidget> on State<T> {
  bool isDidMount = false;
  BuildContext? contextWidget;

  void onDidMount(BuildContext context) {}

  void onBuildFirst(BuildContext context) {}

  void onWidgetRendered(BuildContext context) {}

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (mounted) onWidgetRendered(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    contextWidget = context;
    if (isDidMount == false) {
      isDidMount = true;
      onBuildFirst(context);
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        if (mounted) onDidMount(this.context);
      });
    }
    return widget;
  }
}
