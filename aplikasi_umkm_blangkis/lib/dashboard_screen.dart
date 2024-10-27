import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'update_screen.dart';
import 'payment_screen.dart';
import 'login_screen.dart';
import 'call_center_screen.dart'; // Import layar Call Center
import 'sms_center_screen.dart'; // Import layar SMS Center

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Blangkon A',
      'image': 'assets/images/blangkon1.png',
      'price': 50000,
      'description': 'Blangkon tradisional'
    },
    {
      'name': 'Blangkon B',
      'image': 'assets/images/blangkon2.png',
      'price': 75000,
      'description': 'Blangkon modern'
    },
    {
      'name': 'Blangkon C',
      'image': 'assets/images/blangkon3.png',
      'price': 60000,
      'description': 'Blangkon klasik'
    },
    {
      'name': 'Blangkon D',
      'image': 'assets/images/blangkon4.png',
      'price': 80000,
      'description': 'Blangkon batik'
    },
    {
      'name': 'Blangkon E',
      'image': 'assets/images/blangkon5.png',
      'price': 55000,
      'description': 'Blangkon anak-anak'
    },
    {
      'name': 'Blangkon F',
      'image': 'assets/images/blangkon6.png',
      'price': 70000,
      'description': 'Blangkon budaya'
    },
    {
      'name': 'Blangkon G',
      'image': 'assets/images/blangkon7.png',
      'price': 65000,
      'description': 'Blangkon warna-warni'
    },
    {
      'name': 'Blangkon H',
      'image': 'assets/images/blangkon8.png',
      'price': 90000,
      'description': 'Blangkon eksklusif'
    },
    {
      'name': 'Blangkon I',
      'image': 'assets/images/blangkon9.png',
      'price': 55000,
      'description': 'Blangkon model baru'
    },
    {
      'name': 'Blangkon J',
      'image': 'assets/images/blangkon10.png',
      'price': 85000,
      'description': 'Blangkon limited edition'
    },
  ];

  double _totalSales = 0;

  void _addToCart(double price) {
    setState(() {
      _totalSales += price;
    });
  }

  void _showPaymentForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentScreen(total: _totalSales)),
    );

    if (result == true) {
      setState(() {
        _totalSales = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pembayaran Berhasil!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Ubah status login ke false

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  Future<void> _launchMap() async {
    final Uri mapUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=-7.005145,110.438125');
    await launchUrl(mapUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Call') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CallCenterScreen()),
                );
              } else if (value == 'SMS') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SmsCenterScreen()),
                );
              } else if (value == 'Map') {
                _launchMap();
              } else if (value == 'Update') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateScreen()),
                );
              } else if (value == 'Logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Call', child: Text('Call Center')),
              const PopupMenuItem(value: 'SMS', child: Text('SMS Center')),
              const PopupMenuItem(value: 'Map', child: Text('Lokasi/Maps')),
              const PopupMenuItem(
                  value: 'Update', child: Text('Update User & Password')),
              const PopupMenuItem(
                  value: 'Logout',
                  child: Text('Logout')), // Tambahkan menu Logout
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('Harga: Rp ${product['price']}'),
                  leading: GestureDetector(
                    onTap: () => _addToCart(product['price']),
                    child: Image.asset(product['image']),
                  ),
                  onTap: () => _showProductDetails(context, product),
                );
              },
            ),
          ),
          // Total Sales section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Penjualan: Rp ${_totalSales.toStringAsFixed(0)}'),
                ElevatedButton(
                  onPressed: _totalSales > 0 ? _showPaymentForm : null,
                  child: const Text('Bayar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(product['image']),
            Text(product['description']),
          ],
        ),
      ),
    );
  }
}
