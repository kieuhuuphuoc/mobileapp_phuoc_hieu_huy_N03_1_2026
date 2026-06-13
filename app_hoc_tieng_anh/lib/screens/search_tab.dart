import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/vocabulary.dart';
import '../../services/data_service.dart';
import '../../widgets/word_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Vocabulary> _searchResults = [];
  bool _isSearching = false;

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    final results = DataService.vocabularies.where((word) {
      return word.word.toLowerCase().contains(query.toLowerCase()) ||
             word.meaning.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = true;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tra từ điển',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Nhập từ tiếng Anh cần tra...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Hiển thị kết quả tìm kiếm
          if (_isSearching && _searchResults.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 60,
                      color: AppColors.subtitleColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Không tìm thấy từ nào',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hãy thử tìm kiếm với từ khác',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_isSearching && _searchResults.isNotEmpty)
            Expanded(
              child: ListView.separated(
                itemCount: _searchResults.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final word = _searchResults[index];
                  return WordCard(
                    vocabulary: word,
                    onListen: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Phát âm: ${word.word}')),
                      );
                    },
                  );
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.translate_rounded,
                        size: 60,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tra cứu từ vựng tiếng Anh\nvà cách phát âm chuẩn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.subtitleColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Gợi ý: "apple", "beautiful", "run"',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.subtitleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}