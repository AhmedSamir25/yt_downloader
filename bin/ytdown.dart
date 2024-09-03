import 'dart:io';

import 'package:ytdown/ytdown.dart';

void main(List<String> arguments) {
  
  print("1 for video muxed, 2 for high quality, or 3 for audio only");
  String? choiceNumber = stdin.readLineSync();

  if (choiceNumber == null || 
      (choiceNumber != "1" && choiceNumber != "2" && choiceNumber != "3")) {
    print("Invalid choice, please enter a valid number (1, 2 or 3).");
    return;
  }

  print("Enter video code:");
  String? videoCodeOrUrl = stdin.readLineSync();

  if (videoCodeOrUrl == null || videoCodeOrUrl.isEmpty) {
    print("Invalid input, please enter a valid video URL or code.");
    return;
  }

  String videoName = "";
    print("Enter video name for storage:");
    videoName = stdin.readLineSync() ?? '';
    if (videoName.isEmpty) {
      print("Invalid input, please enter a valid video name.");
      return;
  }
Ytdown ytdown = Ytdown();
  if (choiceNumber == "1") {
    ytdown.videoMuxed(storage: videoName, videoCode: videoCodeOrUrl);
  } else if (choiceNumber == "3") {
    ytdown.videoHighQu(videoCode: videoCodeOrUrl, storage: videoName);
  } else if (choiceNumber == "4") {
    ytdown.audio(videoCode: videoCodeOrUrl, storage: videoName);
  } else {
    print("Error: Invalid choice.");
  }
}

