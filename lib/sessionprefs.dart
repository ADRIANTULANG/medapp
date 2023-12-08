class SessionPrefs {
  String messageID = "";
  String userID = "";

  static final SessionPrefs _singleton = SessionPrefs._internal();

  factory SessionPrefs() {
    return _singleton;
  }

  SessionPrefs._internal();
}