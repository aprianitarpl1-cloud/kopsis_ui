import 'package:flutter/material.dart';
import 'barang_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const List<Map<String, dynamic>> daftarBarang = [
    {
      'nama': 'Buku Tulis Bergaris 58 Lembar Sampul Tebal',
      'anggota': 3000,
      'umum': 3500,
      'stok': 40,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Pulpen',
      'anggota': 2500,
      'umum': 3000,
      'stok': 25,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Roti',
      'anggota': 5000,
      'umum': 5500,
      'stok': 15,
      'kategori': 'Makanan',
    },
    {
      'nama': 'Pensil',
      'anggota': 2000,
      'umum': 2500,
      'stok': 30,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Penghapus',
      'anggota': 1500,
      'umum': 2000,
      'stok': 20,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Penggaris',
      'anggota': 2500,
      'umum': 3000,
      'stok': 18,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Spidol',
      'anggota': 4000,
      'umum': 4500,
      'stok': 12,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Buku Gambar',
      'anggota': 5000,
      'umum': 6000,
      'stok': 0,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Lem Kertas',
      'anggota': 3500,
      'umum': 4000,
      'stok': 14,
      'kategori': 'Alat Tulis',
    },
    {
      'nama': 'Tempat Pensil',
      'anggota': 10000,
      'umum': 12000,
      'stok': 10,
      'kategori': 'Aksesoris',
    },
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String kataCari = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barangTersedia = MyApp.daftarBarang
        .where((barang) => barang['stok'] > 0)
        .toList();

    final hasilCari = barangTersedia
        .where(
          (barang) => barang['nama']
              .toLowerCase()
              .contains(kataCari),
        )
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Cari barang...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (nilai) {
                  setState(() {
                    kataCari = nilai.toLowerCase().trim();
                  });
                },
              ),
            ),

            Text(
              'Lebar layar: ${MediaQuery.of(context).size.width.toStringAsFixed(0)} px',
            ),

            const SizedBox(height: 10),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int kolom;

                  if (constraints.maxWidth < 600) {
                    kolom = 1;
                  } else if (constraints.maxWidth < 900) {
                    kolom = 2;
                  } else {
                    kolom = 3;
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: hasilCari.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kolom,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final barang = hasilCari[index];

                      return BarangCard(
                        nama: barang['nama'],
                        hargaAnggota: barang['anggota'],
                        stok: barang['stok'],
                        kategori: barang['kategori'],
                        sorot: barang['stok'] <= 15,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}