import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/product.dart';
import 'add_edit_page.dart';
import 'detail_page.dart';
import 'login_page.dart';
import '../utils/session.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool grid = false;
  final db = DBHelper();
  List<Product> data = [];

  load() async {
    data = await db.getAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  Widget card(Product p) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFF1E88E5),
            child: Icon(Icons.shopping_bag, color: Colors.white),
          ),
          title: Text(
            p.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Rp ${p.price}"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(product: p)),
            );
            load();
          },
        ),
      );

  Future<void> logout() async {
    await Session.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text("Daftar Produk"),
        actions: [
          IconButton(
            icon: Icon(grid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => grid = !grid),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditPage()),
          );
          load();
        },
      ),
      body: data.isEmpty
          ? const Center(
              child: Text(
                "Belum ada data",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : grid
              ? GridView.count(
                  padding: const EdgeInsets.all(12),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: data.map(card).toList(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: data.length,
                  itemBuilder: (_, i) => card(data[i]),
                ),
    );
  }
}
