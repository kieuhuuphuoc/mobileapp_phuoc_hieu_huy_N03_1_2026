import 'dart:async';
import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../models/user.dart';
import '../services/data_service.dart';
import '../services/study_service.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart' as auth;
import 'lesson_screen.dart';
import 'quiz_screen.dart';
import 'flashcard_screen.dart';
import 'topic_select_screen.dart';
import 'activity_tab.dart';
import 'classes_tab.dart';
import 'profile_tab.dart';
import 'search_tab.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _studyService = StudyService();
  late Future<Map<String, dynamic>> _summaryFuture;
  int _selectedIndex = 0;
  
  // Dùng StreamController để refresh
  final _topicStreamController = StreamController<void>.broadcast();

  @override
  void initState() {
    super.initState();
    _summaryFuture = _loadSummary();
  }

  @override
  void dispose() {
    _topicStreamController.close();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadSummary() async {
    await _studyService.markTodayStudied();
    return _studyService.getSummary();
  }

  void _refreshSummary() {
    setState(() {
      _summaryFuture = _studyService.getSummary();
    });
  }

  void _openTopicSelector(TopicSelectMode mode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TopicSelectScreen(
          mode: mode,
          onTopicSelected: (topic) {
            Navigator.pop(context);
            if (mode == TopicSelectMode.lesson) {
              _openLesson(topic);
            } else {
              _openQuiz(topic);
            }
          },
        ),
      ),
    );
  }

  void _openLesson(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(topic: topic)),
    ).then((_) {
      if (mounted) {
        setState(() {});
        _refreshSummary();
      }
    });
  }

  void _openQuiz(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(topic: topic)),
    ).then((_) {
      if (mounted) _refreshSummary();
    });
  }

  void _openFlashcard(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FlashcardScreen(topic: topic)),
    ).then((_) {
      if (mounted) _refreshSummary();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // === THÊM CHỦ ĐỀ (DÙNG STREAM) ===
  Future<void> _showAddTopicDialog() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final colorOptions = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    int selectedColorIndex = 0;
    final iconOptions = [
      Icons.family_restroom,
      Icons.school_outlined,
      Icons.restaurant_outlined,
      Icons.sports_esports,
      Icons.music_note,
      Icons.brush,
      Icons.airplane_ticket,
      Icons.fitness_center,
    ];
    int selectedIconIndex = 0;

    try {
      final topic = await showDialog<Topic>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Thêm chủ đề mới'),
                content: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Tên chủ đề',
                            border: OutlineInputBorder(),
                            hintText: 'Ví dụ: Động vật, Màu sắc...',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập tên chủ đề';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả',
                            border: OutlineInputBorder(),
                            hintText: 'Mô tả ngắn về chủ đề này',
                          ),
                          maxLines: 2,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Vui lòng nhập mô tả';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Chọn màu sắc:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: List.generate(colorOptions.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  selectedColorIndex = index;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: colorOptions[index],
                                  shape: BoxShape.circle,
                                  border: selectedColorIndex == index
                                      ? Border.all(color: Colors.black, width: 3)
                                      : null,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        const Text('Chọn biểu tượng:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: List.generate(iconOptions.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  selectedIconIndex = index;
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: selectedIconIndex == index
                                      ? AppColors.primary.withOpacity(0.2)
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: selectedIconIndex == index
                                      ? Border.all(color: AppColors.primary, width: 2)
                                      : null,
                                ),
                                child: Icon(
                                  iconOptions[index],
                                  color: selectedIconIndex == index
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Hủy'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      final topic = DataService.addTopic(
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        icon: iconOptions[selectedIconIndex],
                        color: colorOptions[selectedColorIndex],
                      );
                      Navigator.pop(dialogContext, topic);
                    },
                    child: const Text('Thêm'),
                  ),
                ],
              );
            },
          );
        },
      );

      if (topic != null) {
        // Gửi sự kiện refresh qua stream
        _topicStreamController.add(null);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Đã thêm chủ đề "${topic.name}" thành công!'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } finally {
      nameController.dispose();
      descriptionController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    
    int crossAxisCount = 2;
    if (isDesktop) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }

    final List<Widget> _pages = [
      // Tab 0: Khám phá
      RefreshIndicator(
        onRefresh: () async => _refreshSummary(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 16),
                child: Text(
                  'Xin chào, ${widget.user.name}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              _HeroPanel(userName: widget.user.name),
              const SizedBox(height: 20),
              FutureBuilder<Map<String, dynamic>>(
                future: _summaryFuture,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return _StudyDashboard(summary: data);
                },
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.menu_book_outlined,
                          label: 'Học từ vựng',
                          subtitle: 'Chọn chủ đề để học',
                          color: AppColors.primary,
                          onTap: () => _openTopicSelector(TopicSelectMode.lesson),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.quiz_outlined,
                          label: 'Luyện quiz',
                          subtitle: 'Kiểm tra ghi nhớ',
                          color: AppColors.accent,
                          onTap: () => _openTopicSelector(TopicSelectMode.quiz),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.style_rounded,
                          label: 'Flashcard',
                          subtitle: 'Học từ vựng với thẻ',
                          color: const Color(0xFF8B5CF6),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TopicSelectScreen(
                                  mode: TopicSelectMode.lesson,
                                  onTopicSelected: (topic) {
                                    Navigator.pop(context);
                                    _openFlashcard(topic);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Khám phá chủ đề',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showAddTopicDialog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Thêm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // === DÙNG STREAMBUILDER ĐỂ HIỂN THỊ DANH SÁCH CHỦ ĐỀ ===
              StreamBuilder<void>(
                stream: _topicStreamController.stream,
                builder: (context, snapshot) {
                  // Không cần dùng snapshot.data, chỉ cần rebuild khi có sự kiện
                  final topics = DataService.topics;
                  if (topics.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.inbox, size: 64, color: AppColors.subtitleColor),
                          SizedBox(height: 16),
                          Text(
                            'Chưa có chủ đề nào',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.subtitleColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Hãy thêm chủ đề đầu tiên của bạn!',
                            style: TextStyle(color: AppColors.subtitleColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isDesktop ? 0.9 : 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return _ModernTopicCard(
                        topic: topic,
                        onTap: () => _openLesson(topic),
                        onQuizTap: () => _openQuiz(topic),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      
      // Tab 1: Tìm kiếm
      const SearchTab(),
      
      // Tab 2: Hoạt động
      const ActivityTab(),
      
      // Tab 3: Lớp học
      const ClassesTab(),
      
      // Tab 4: Tài khoản
      ProfileTab(userName: widget.user.name),
      
      // Tab 5: Thống kê
      const StatisticsScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: null,
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              tooltip: 'Đăng xuất',
              icon: const Icon(Icons.logout, color: AppColors.textColor),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => auth.LoginScreen()),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 26),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 26),
              label: 'Tìm kiếm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_empty, size: 26),
              label: 'Hoạt động',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined, size: 26),
              label: 'Lớp học',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              label: 'Tài khoản',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 26),
              label: 'Thống kê',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CÁC WIDGET (Giữ nguyên)
// ============================================================

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    
    return Container(
      width: double.infinity,
      height: isDesktop ? 200 : 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF2563EB),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: 24,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "English Daily",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "🎯 Hôm nay học 10 từ mới",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyDashboard extends StatelessWidget {
  const _StudyDashboard({required this.summary});

  final Map<String, dynamic>? summary;

  @override
  Widget build(BuildContext context) {
    final streak = summary?['streak'] ?? 0;
    final days = summary?['days'] ?? 0;
    final lessons = summary?['lessons'] ?? 0;
    final quizzes = summary?['quizzes'] ?? 0;
    final score = summary?['score'] ?? 0;
    final total = summary?['total'] ?? 0;
    final accuracy = total == 0 ? 0 : ((score / total) * 100).round();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SmallStatCard(
                icon: Icons.event_available,
                label: 'Điểm danh',
                value: '$streak ngày',
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SmallStatCard(
                icon: Icons.bolt,
                label: 'Ngày học',
                value: '$days',
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SmallStatCard(
                icon: Icons.menu_book,
                label: 'Bài học',
                value: '$lessons',
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SmallStatCard(
                icon: Icons.quiz,
                label: 'Lượt quiz',
                value: '$quizzes',
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AccuracyCard(accuracy: accuracy, score: score, total: total),
        const SizedBox(height: 12),
        _WeekAttendance(summary: summary),
      ],
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  const _SmallStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccuracyCard extends StatelessWidget {
  const _AccuracyCard({
    required this.accuracy,
    required this.score,
    required this.total,
  });

  final int accuracy;
  final int score;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.analytics_outlined,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Độ chính xác: $accuracy%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      '$score đúng',
                      style: const TextStyle(
                        color: AppColors.subtitleColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : accuracy / 100,
                    minHeight: 6,
                    color: AppColors.primary,
                    backgroundColor: const Color(0xFFE5E7EB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekAttendance extends StatelessWidget {
  const _WeekAttendance({required this.summary});

  final Map<String, dynamic>? summary;

  @override
  Widget build(BuildContext context) {
    final recentRows = (summary?['recentDays'] as List?) ?? [];
    final studiedDates = recentRows.map((row) => row['date'] as String).toSet();
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔥 Hoạt động tuần này',
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final date = today.subtract(Duration(days: 6 - index));
              final key = _dateKey(date);
              final checked = studiedDates.contains(key);
              return _DayDot(
                label: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'][index],
                checked: checked,
              );
            }),
          ),
        ],
      ),
    );
  }

  String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.label, required this.checked});

  final String label;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: checked ? AppColors.success : const Color(0xFFF1F5F9),
          ),
          child: Icon(
            checked ? Icons.check : Icons.close,
            color: checked ? Colors.white : Colors.grey,
            size: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.subtitleColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Bắt đầu",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernTopicCard extends StatelessWidget {
  const _ModernTopicCard({
    required this.topic,
    required this.onTap,
    required this.onQuizTap,
  });

  final Topic topic;
  final VoidCallback onTap;
  final VoidCallback onQuizTap;

  @override
  Widget build(BuildContext context) {
    final wordCount = DataService.getVocabulariesByTopic(topic.id).length;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header với background màu
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: topic.color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    top: -10,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: topic.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      topic.icon,
                      color: topic.color,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$wordCount từ vựng',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Button tham gia
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: topic.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Tham gia',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}