String formatLastSeen(DateTime? lastSeen) {
  if (lastSeen == null) return 'Last seen recently';
  final diff = DateTime.now().difference(lastSeen);
  if (diff.inSeconds < 60) return 'Last seen just now';
  if (diff.inMinutes < 60) {
    final m = diff.inMinutes;
    return 'Last seen $m min ago';
  }
  if (diff.inHours < 24) {
    final h = lastSeen.hour == 0
        ? 12
        : (lastSeen.hour > 12 ? lastSeen.hour - 12 : lastSeen.hour);
    final ampm = lastSeen.hour >= 12 ? 'PM' : 'AM';
    final mm = lastSeen.minute.toString().padLeft(2, '0');
    return 'Last seen today at ${h.toString().padLeft(2, '0')}:$mm $ampm';
  }
  if (diff.inDays == 1) return 'Last seen yesterday';
  if (diff.inDays < 7) return 'Last seen ${diff.inDays} days ago';
  return 'Last seen a while ago';
}

String formatDateLabel(DateTime dt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final msgDay = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(msgDay).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    return weekdays[dt.weekday - 1];
  }
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[dt.month - 1]} ${dt.day}';
}

String formatTime(DateTime dt) {
  final h = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
  final ampm = dt.hour >= 12 ? 'PM' : 'AM';
  final mm = dt.minute.toString().padLeft(2, '0');
  return '${h.toString().padLeft(2, '0')}:$mm $ampm';
}
