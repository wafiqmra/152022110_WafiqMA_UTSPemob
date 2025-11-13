import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk contoh berita
    final List<Map<String, dynamic>> newsList = [
      {
        'category': 'seputar indonesia',
        'categoryColor': Colors.blue,
        'title': 'Bencana banjir',
        'description': 'Banjir di jakarta melanda pemukiman.',
        'date': '13 may 2024',
      },
      {
        'category': 'AI',
        'categoryColor': Colors.purple,
        'title': 'Pengembangan AI Terbaru di jawa',
        'description': 'Startup jawa berhasil mengembangkan model AI ngawi.',
        'date': '14 jan 2025',
      },
      {
        'category': 'finance',
        'categoryColor': Colors.green,
        'title': 'Bill gates bangkrut',
        'description': 'kerugian bill gates mencapai 400 miliar dollar.',
        'date': '12 okt 2024',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Application'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.article, color: Colors.grey),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: news['categoryColor'].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        news['category'],
                        style: TextStyle(
                          color: news['categoryColor'],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      news['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      news['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          news['date'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            );
          },
        ),
      ),
    );
  }
}
