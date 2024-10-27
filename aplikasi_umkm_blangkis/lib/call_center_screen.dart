// call_center_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterScreen extends StatelessWidget {
  const CallCenterScreen({super.key});

  // Fungsi untuk membuka WhatsApp
  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      debugPrint('Tidak dapat membuka WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Center'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () =>
              _launchWhatsApp('6282314213239'), // Nomor Call Center
          icon: Icon(Icons.call),
          label: Text('Hubungi Call Center via WhatsApp'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          ),
        ),
      ),
    );
  }
}
