class PresenceStatus {
  const PresenceStatus({required this.online, this.lastSeen});
  final bool online;
  final DateTime? lastSeen;
}
