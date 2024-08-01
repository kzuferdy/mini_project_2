class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'].toString()) ?? 0, // Konversi String ke int
      title: json['title'], // Judul produk
      description: json['description'], // Deskripsi produk
      category: json['category'], // Kategori produk
      image: json['image'], // URL gambar produk
      price: (json['price'] as num).toDouble(), // Harga produk, konversi ke double
    );
  }
}
