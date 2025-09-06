class VideoCallSessionEntity {
  final int videoCallSessionId;
  final int appointmentId;
  final DateTime startTime;
  final DateTime endTime;
  final String sessionStatus; // 'Started', 'InProgress', 'Ended'
  final String participants; // JSON string or custom list of userIds

  VideoCallSessionEntity({
    required this.videoCallSessionId,
    required this.appointmentId,
    required this.startTime,
    required this.endTime,
    required this.sessionStatus,
    required this.participants,
  });
}
