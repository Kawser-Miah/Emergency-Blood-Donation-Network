enum RequestStatus {
  active('active'),
  fulfilled('fulfilled'),
  cancelled('cancelled'),
  expired('expired');

  const RequestStatus(this.value);
  final String value;

  static RequestStatus fromString(String value) {
    return RequestStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RequestStatus.active,
    );
  }
}
