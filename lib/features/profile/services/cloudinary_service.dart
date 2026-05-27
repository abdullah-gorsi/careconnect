import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  // TODO: Replace these with your actual Cloudinary credentials
  static const String _cloudName = 'ddeelsbrd';
  static const String _uploadPreset = 'profile_preset';
  
  static const String _baseUrl = 'https://api.cloudinary.com/v1_1';

  /// Uploads an image file to Cloudinary and returns the secure URL
  /// 
  /// [imageFile] - The image file to upload
  /// 
  /// Returns the secure HTTPS URL of the uploaded image
  /// 
  /// Throws [Exception] if upload fails
  Future<String> uploadImage(XFile imageFile) async {
    try {
      final url = Uri.parse('$_baseUrl/$_cloudName/image/upload');
      
      // Create multipart request
      final request = http.MultipartRequest('POST', url);
      
      // Add upload preset
      request.fields['upload_preset'] = _uploadPreset;
      
      // Add the image file
      final imageBytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);
      
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      // Check response status
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final secureUrl = responseData['secure_url'] as String;
        return secureUrl;
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Cloudinary upload failed: ${errorData['error']?['message'] ?? 'Unknown error'}');
      }
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection');
    } on FormatException {
      throw Exception('Invalid response from Cloudinary');
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
