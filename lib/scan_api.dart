// Autogenerated from Pigeon (v7.2.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum ScannerType {
  tsd,
  camera,
}

class CameraProperties {
  CameraProperties({
    required this.textureId,
    required this.aspectRatio,
    required this.width,
    required this.height,
  });

  int textureId;

  double aspectRatio;

  int width;

  int height;

  Object encode() {
    return <Object?>[
      textureId,
      aspectRatio,
      width,
      height,
    ];
  }

  static CameraProperties decode(Object result) {
    result as List<Object?>;
    return CameraProperties(
      textureId: result[0]! as int,
      aspectRatio: result[1]! as double,
      width: result[2]! as int,
      height: result[3]! as int,
    );
  }
}

class StartScanResult {
  StartScanResult({
    required this.scannerType,
    this.cameraProperties,
  });

  ScannerType scannerType;

  CameraProperties? cameraProperties;

  Object encode() {
    return <Object?>[
      scannerType.index,
      cameraProperties?.encode(),
    ];
  }

  static StartScanResult decode(Object result) {
    result as List<Object?>;
    return StartScanResult(
      scannerType: ScannerType.values[result[0]! as int],
      cameraProperties: result[1] != null
          ? CameraProperties.decode(result[1]! as List<Object?>)
          : null,
    );
  }
}

class _ScanHostApiCodec extends StandardMessageCodec {
  const _ScanHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CameraProperties) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is StartScanResult) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return CameraProperties.decode(readValue(buffer)!);
      case 129: 
        return StartScanResult.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ScanHostApi {
  /// Constructor for [ScanHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ScanHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ScanHostApiCodec();

  Future<StartScanResult> startScan() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ScanHostApi.startScan', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as StartScanResult?)!;
    }
  }

  Future<void> stopScan() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.ScanHostApi.stopScan', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class ScanFlutterApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  void onScan(String data);

  static void setup(ScanFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ScanFlutterApi.onScan', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.ScanFlutterApi.onScan was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_data = (args[0] as String?);
          assert(arg_data != null,
              'Argument for dev.flutter.pigeon.ScanFlutterApi.onScan was null, expected non-null String.');
          api.onScan(arg_data!);
          return;
        });
      }
    }
  }
}
