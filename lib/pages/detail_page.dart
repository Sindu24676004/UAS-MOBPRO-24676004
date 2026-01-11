import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product.dart';
import '../database/db_helper.dart';
import 'add_edit_page.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage({required this.product});

  Future<void> openWA() async {
    final uri = Uri.parse(
        "https://api.whatsapp.com/send?phone=6285740533424&text=Halo, Saya mau pesan barang");

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await DBHelper().delete(product.id!);
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // kembali ke home
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Harga: Rp ${product.price}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: openWA,
              child: const Text("WhatsApp"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddEditPage(product: product)),
              ),
              child: const Text("Edit"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => confirmDelete(context),
              child: const Text("Hapus"),
            ),
          ],
        ),
      ),
    );
  }
}
