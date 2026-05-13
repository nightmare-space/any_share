import 'device_type.dart';

class Device {
  Device(
    this.id, {
    this.deviceType,
    this.deviceName,
    this.url,
    this.messagePort,
  });
  String? id;
  DeviceType? deviceType;
  String? deviceName;
  // url prefix
  String? url;
  int? messagePort;
  bool isAlive = true;

  /// 当一个新的设备连接到当前设备的时候，需要回一个连接消息。
  ///
  /// 用来处理 UDP 广播只有 A -> B，没有 B -> A 的情况，
  /// 导致 A 的连接列表没有 B。
  ///
  /// 这个在设备心跳包没有收到的情况下，会再次置为 false。
  ///
  /// 保证：
  /// A 启动 -> B 启动 -> A 连过 B -> A 关闭 -> A 再打开
  /// 即使只有 B 连过 A，B 依然会主动给 A 发送连接消息。
  ///
  /// When a new device connects to the current device, a connection message needs to be sent back.
  ///
  /// This is used to handle the situation where there is only A -> B in UDP broadcast, and no B -> A, which leads to A's connection list not having B.
  /// This will be set to false again when the device heartbeat is not received.
  ///
  /// Ensure:
  /// A starts -> B starts -> A connects to B -> A closes -> A opens again
  /// Even if only B connects to A, B will still actively send a connection message to A.
  bool sendedJoinMessage = false;

  /// 防止重复发送，因为时序的问题，A 可能会收到两次 B 的 JoinMessage
  ///
  /// Prevent duplicate sending, because of the timing issue, A may receive B's JoinMessage twice.
  bool sendedHistoryMessage = false;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Device) {
      return id == other.id;
    }
    return false;
  }

  @override
  String toString() {
    return 'id:$id deviceType:$deviceType deviceName:$deviceName address:$url';
  }
}
