part of lib_ui;

class SnackBarHelper {
  ///Props [duration] are milliseconds
  static void show({
    SnackBarStatus status = SnackBarStatus.normal,
    int duration = 3000,
    String content = '',
    bool isAction = false,
  }) {
    try {
      Navigation.messengerKey.currentState!.hideCurrentSnackBar();
      Navigation.messengerKey.currentState!.showSnackBar(SnackBar(
          backgroundColor: status.background,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            onPressed: () {},
            textColor: Colors.white,
            label: isAction ? 'DISMISS' : '',
          ),
          content: Text(content,
              style: const TextStyle(
                color: Colors.white
              )),
          duration: Duration(milliseconds: duration)));
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

enum SnackBarStatus { success, error, normal}

extension on SnackBarStatus {
  Color get background {
    switch (this) {
      case SnackBarStatus.success:
        return Colors.green;
      case SnackBarStatus.error:
        return Colors.red;
      default:
        return Colors.black38;
    }
  }
}
