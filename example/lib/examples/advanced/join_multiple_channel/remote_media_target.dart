class RemoteMediaTarget {
  const RemoteMediaTarget({
    required this.channelId,
    required this.localUid,
    required this.remoteUid,
  });

  final String channelId;
  final int localUid;
  final int remoteUid;
}

RemoteMediaTarget? resolveRemoteMediaTarget({
  required String? renderChannelId,
  required int? channel0LocalUid,
  required int? channel1LocalUid,
  required List<int> remoteUid0,
  required List<int> remoteUid1,
  required String remoteUidText,
}) {
  final remoteUid = int.tryParse(remoteUidText);
  if (remoteUid == null) {
    return null;
  }
  if (renderChannelId == 'channel0' &&
      channel0LocalUid != null &&
      remoteUid0.contains(remoteUid)) {
    return RemoteMediaTarget(
      channelId: 'channel0',
      localUid: channel0LocalUid,
      remoteUid: remoteUid,
    );
  }
  if (renderChannelId == 'channel1' &&
      channel1LocalUid != null &&
      remoteUid1.contains(remoteUid)) {
    return RemoteMediaTarget(
      channelId: 'channel1',
      localUid: channel1LocalUid,
      remoteUid: remoteUid,
    );
  }
  return null;
}
