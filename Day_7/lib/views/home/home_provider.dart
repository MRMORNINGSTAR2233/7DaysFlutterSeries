import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

final homeProvider =
    ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isSearching = false;
  Uint8List? imageData;

  void loadingChange(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchingChange(bool val) {
    isSearching = val;
    notifyListeners();
  }

  Future<dynamic> textToImage(String prompt, BuildContext context) async {
    String engineId = "stable-diffusion-v1-6";
    String apiHost = 'https://api.stability.ai';
    String apiKey = 'Enter your api key here';
    debugPrint(prompt);

    final response = await http.post(
        Uri.parse('$apiHost/v1/generation/$engineId/text-to-image'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "image/png",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode({
          "text_prompts": [
            {
              "text": prompt,
              "weight": 1,
            }
          ],
          "cfg_scale": 7,
          "height": 1024,
          "width": 1024,
          "samples": 1,
          "steps": 30,
        }));

    if (response.statusCode == 200) {
      try {
        imageData = response.bodyBytes;
        loadingChange(true);
        searchingChange(false);
        notifyListeners();

        // After generating the image, save it to MongoDB by sending it to your backend
        await saveImageToMongoDB(imageData!, prompt);
      } on Exception {
        debugPrint("Failed to generate image");
      }
    } else {
      debugPrint("Failed to generate image");
    }
  }

  // Save the image to MongoDB through backend API
  Future<void> saveImageToMongoDB(Uint8List imageData, String prompt) async {
    String apiHost = 'http://127.0.0.1:8000'; // Replace with your backend URL

    try {
      String base64Image = base64Encode(imageData);

      final response = await http.post(
        Uri.parse('$apiHost/save_image/'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({"image_base64": base64Image, "prompt": prompt}),
      );

      if (response.statusCode == 200) {
        debugPrint("Image saved to MongoDB successfully.");
      } else {
        debugPrint("Failed to save image to MongoDB: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error saving image to MongoDB: $e");
    }
  }
}
