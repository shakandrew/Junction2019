import 'package:flutter/services.dart';

class SelfShare {
  static const MethodChannel _channel = const MethodChannel('self_share');
  static Future<bool> is24HoursFormat() async {
    return await _channel.invokeMethod("is24HoursFormat");
  }

  static showToast(String text) async {
    return await _channel.invokeMethod('showToast', {"text": text});
  }

  static shareTikTok(String clipboard, List<String> files) async {
    return await _channel.invokeMethod('shareTikTok', {
      "clipboard": clipboard,
      "files": files.join("=#=#="),
    });
  }

  static checkTikTok() async {
    return await _channel.invokeMethod('checkTikTok');
  }

  static shareInstagramMultiple(String clipboard, List<String> files) async {
    return await _channel.invokeMethod('shareInstagramMultiple', {
      "clipboard": clipboard,
      "files": files.join("=#=#="),
    });
  }

  static shareInstagram(
      bool isVideo, bool isStory, String path, String clipboard) async {
    return await _channel.invokeMethod('shareInstagram', {
      "path": path,
      "isStory": isStory,
      "isVideo": isVideo,
      "clipboard": clipboard,
    });
  }

  static checkInstagram() async {
    return await _channel.invokeMethod('checkInstagram');
  }

  static shareTwitter(String clipboard, List<String> files) async {
    return await _channel.invokeMethod('shareTwitter', {
      "clipboard": clipboard,
      "files": files.join("=#=#="),
    });
  }

  static checkTwitter() async {
    return await _channel.invokeMethod('checkTwitter');
  }
}
