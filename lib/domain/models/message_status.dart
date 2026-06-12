enum MessageStatus {
  sending,
  sent,
  read;

  String toJson() => name;

  static MessageStatus fromString(String value) {
    return MessageStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MessageStatus.sent,
    );
  }
}
