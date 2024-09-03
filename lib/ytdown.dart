import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Ytdown {
  var yt = YoutubeExplode();

  String get userDownloadPath {
    String? userProfilePath = Platform.environment['USERPROFILE'];
    String? userName = userProfilePath?.split('\\').last;

    if (userName == null) {
      throw Exception('Unable to determine the current user name.');
    }

    return 'C:/Users/$userName/Downloads/';
  }

  void videoMuxed({required String storage, required String videoCode}) async {
    var manifest = await yt.videos.streamsClient.getManifest(videoCode);
    var streamInfo = manifest.muxed.withHighestBitrate();

    print(streamInfo.videoResolution);
    print(streamInfo.videoQuality);

    var stream = yt.videos.streamsClient.get(streamInfo);
    var contentLength = streamInfo.size.totalBytes;

    var file = File('$userDownloadPath$storage.mp4');
    var fileStream = file.openWrite();

    var downloaded = 0;
    var lastPrintedProgress = 0;

    await for (final data in stream) {
      downloaded += data.length;
      fileStream.add(data);

      var progress = (downloaded / contentLength * 100).round();

      if (progress != lastPrintedProgress) {
        stdout.write('\rDownloading: $progress%');
        lastPrintedProgress = progress;
      }
    }

    await fileStream.flush();
    await fileStream.close();

    print('\nDownload complete!');
  }

  void videoHighQu({required String videoCode, required String storage}) async {
    var manifest = await yt.videos.streamsClient.getManifest(videoCode);
    var streamInfo = manifest.video.withHighestBitrate();
    print(streamInfo);

    var stream = yt.videos.streamsClient.get(streamInfo);
    var contentLength = streamInfo.size.totalBytes;

    var file = File('$userDownloadPath$storage.mp4');
    var fileStream = file.openWrite();

    var downloaded = 0;
    var lastPrintedProgress = 0;

    await for (final data in stream) {
      downloaded += data.length;
      fileStream.add(data);

      var progress = (downloaded / contentLength * 100).round();

      if (progress != lastPrintedProgress) {
        stdout.write('\rDownloading: $progress%');
        lastPrintedProgress = progress;
      }
    }

    await fileStream.flush();
    await fileStream.close();

    print('\nDownload complete!');
  }

  void audio({required String videoCode, required String storage}) async {
    var manifest = await yt.videos.streamsClient.getManifest(videoCode);
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    print(streamInfo);

    var stream = yt.videos.streamsClient.get(streamInfo);
    var contentLength = streamInfo.size.totalBytes;

    var file = File('$userDownloadPath$storage.mp3');
    var fileStream = file.openWrite();

    var downloaded = 0;
    var lastPrintedProgress = 0;

    await for (final data in stream) {
      downloaded += data.length;
      fileStream.add(data);

      var progress = (downloaded / contentLength * 100).round();

      if (progress != lastPrintedProgress) {
        stdout.write('\rDownloading: $progress%');
        lastPrintedProgress = progress;
      }
    }

    await fileStream.flush();
    await fileStream.close();

    print('\nDownload complete!');
  }
}
