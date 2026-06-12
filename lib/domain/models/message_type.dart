enum MessageType {
  text,
  image,
  location,
  certificate;

  String toJson() => name;

  static MessageType fromString(String value) {
    return MessageType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MessageType.text,
    );
  }
}
