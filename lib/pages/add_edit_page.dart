import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/product.dart';

class AddEditPage extends StatelessWidget {
  final Product? product;
  AddEditPage({this.product});

  final nameC = TextEditingController();
  final priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (product != null) {
      nameC.text = product!.name;
      priceC.text = product!.price.toString();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Form Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameC,
                decoration: const InputDecoration(labelText: "Nama")),
            TextField(
                controller: priceC,
                decoration: const InputDecoration(labelText: "Harga")),
            ElevatedButton(
              onPressed: () async {
                final db = DBHelper();
                final p = Product(
                  id: product?.id,
                  name: nameC.text,
                  price: int.parse(priceC.text),
                );
                product == null ? await db.insert(p) : await db.update(p);
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
