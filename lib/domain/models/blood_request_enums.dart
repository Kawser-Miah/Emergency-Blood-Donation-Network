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

enum CloseReason {
  receivedEnoughDonors('received_enough_donors'),
  foundAnotherSource('found_another_source'),
  doctorNoLongerNeeded('doctor_no_longer_needed'),
  other('other');

  const CloseReason(this.value);
  final String value;

  static CloseReason fromString(String value) {
    return CloseReason.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CloseReason.other,
    );
  }
}
