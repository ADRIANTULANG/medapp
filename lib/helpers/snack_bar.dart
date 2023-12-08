import 'package:flutter/material.dart';

class Snackbar {
  void showSnack(
    String message,
    GlobalKey<ScaffoldState> _scaffoldKey,
    Function? undo,
  ) {
    if(_scaffoldKey.currentContext != null){
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
        content: Text(message),
        action: undo != null
            ? SnackBarAction(
                textColor: Theme.of(_scaffoldKey.currentContext!).primaryColor,
                label: "Undo",
                onPressed: () => undo(), // Call the undo function
              )
            : null,
      ),
      );
    }
  }
}

