import 'package:agora_rtc_engine_example/examples/advanced/picture_in_picture_join_channel_ex/picture_in_picture_join_channel_ex.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('can construct PictureInPictureJoinChannelEx widget', () {
    expect(
      const PictureInPictureJoinChannelEx(),
      isA<PictureInPictureJoinChannelEx>(),
    );
  });

  test('creates two distinct joinChannelEx connections', () {
    final connections = buildPictureInPictureJoinChannelExConnections(
      uid0: 1000,
      uid1: 1001,
    );

    expect(connections.length, 2);
    expect(connections[0].channelId, 'channel0');
    expect(connections[0].localUid, 1000);
    expect(connections[1].channelId, 'channel1');
    expect(connections[1].localUid, 1001);
  });
}
