import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double total;

  const PaymentScreen({Key? key, required this.total}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${_nameController.text}'),
            Text('Alamat: ${_addressController.text}'),
            Text('Total Pembayaran: Rp ${widget.total.toStringAsFixed(0)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Tutup dialog dan tampilkan notifikasi pembayaran berhasil
              Navigator.of(context).pop(); // Menutup dialog konfirmasi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pembayaran berhasil')),
              );
              Navigator.of(context).pop(); // Kembali ke halaman Dashboard
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    if (_nameController.text.isNotEmpty && _addressController.text.isNotEmpty) {
      print('Nama: ${_nameController.text}');
      print('Alamat: ${_addressController.text}');
      print('Total Pembayaran: Rp ${widget.total.toStringAsFixed(0)}');
      _showConfirmationDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama dan alamat')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            const SizedBox(height: 32),
            Text('Total Pembayaran: Rp ${widget.total.toStringAsFixed(0)}'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _processPayment,
              child: const Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
