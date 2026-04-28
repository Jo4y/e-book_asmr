import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AsmrApp());
}

// 1. 製作包含多個頁面的電子書 App
class AsmrApp extends StatelessWidget {
  const AsmrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASMR e-Book',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.black,
          surface: Colors.white,
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          surfaceTintColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFEAEAEA),
          thickness: 1,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: const WelcomePage(), // 進入頁面
    );
  }
}

// ==========================================
// 3. 定義資料的型別 (Data Model)
// ==========================================
class AsmrItem {
  final String title;
  final String category;
  final String imageUrl;
  final String? audioPath; 
  final String? videoPath; 
  
  final String mainDescription; // 主要說明
  final String triggerType;     // 呈現方式 (或觸發類型)
  final String specialNotes;    // 補充、特別處

  AsmrItem({
    required this.title,
    required this.mainDescription,
    required this.triggerType,
    required this.specialNotes,
    required this.category,
    required this.imageUrl,
    required this.audioPath,
    required this.videoPath,
  });
}

final List<AsmrItem> dummyData = [
  AsmrItem(
    title: 'Tapping (敲擊聲)', 
    category: 'Physical & Object Sounds', 
    imageUrl: 'assets/tapping.png',
    audioPath: 'audio/tapping.mp3',
    videoPath: 'assets/video/tapping.mp4',
    mainDescription: '實體物品間接觸時所產生的，規律亦或不規律的聲音。如指甲或指腹輕敲木頭、玻璃、塑膠或金屬表面的清脆聲音。',
    triggerType: '以指甲或指腹敲擊物品，或是讓物品互相碰撞。',
    specialNotes: '最經典的 ASMR 觸發音之一，也是最隨手可"做"的ASMR。',
  ),
  AsmrItem(
    title: 'Scratching (抓撓聲)', 
    mainDescription: '在麥克風或粗糙表面上輕抓的聲音。麥克風上通常會加上絨毛或絨布增加體驗感，不過也可以直接刮麥克風本體，都會呈現不同的感受。', 
    triggerType: '以手在麥克風上輕輕摩擦。', 
    specialNotes: '由於非常貼近麥克風，收音起來更有"沉浸"在ASMR之感。', 
    category: 'Physical & Object Sounds', 
    imageUrl: 'assets/scratching.png', 
    audioPath: 'audio/scratching.mp3', 
    videoPath: 'assets/video/scratching.mp4'
  ),
  AsmrItem(
    title: 'Clicking(鍵盤敲擊聲)', 
    mainDescription: '鍵盤敲擊的聲音。', 
    triggerType: '像我們平常打電腦一樣敲擊鍵盤，規律亦或不規律。', 
    specialNotes: '可以聽不同軸體的鍵盤聲，根據當下心情選擇想要清脆一點的聲音，還是悶一點的。', 
    category: 'Physical & Object Sounds', 
    imageUrl: 'assets/clicking.png', 
    audioPath: 'audio/clicking.mp3', 
    videoPath: 'assets/video/clicking.mp4'
  ),
  AsmrItem(
    title: 'Mouth Sounds (口腔聲)', 
    mainDescription: '嘴巴發出的聲音，包含唇齒間的聲音、狀聲詞等。', 
    triggerType: '嘴巴靠近麥克風，發出各式狀聲詞，靈活運用唇齒及舌頭間發出的聲音變化。', 
    specialNotes: '有fast mouth sound及slow mouth sound的分別，滿足不同偏好的人。', 
    category: 'Vocal & Mouth Sounds', 
    imageUrl: 'assets/mouth_sound.png', 
    audioPath: 'audio/mouth_sound.mp3', 
    videoPath: 'assets/video/mouth_sound.mp4'
  ),
  AsmrItem(
    title: 'Whispering (耳語)', 
    mainDescription: '輕柔的氣音說話聲，是最經典的觸發音。', 
    triggerType: '壓低音量或直接使用氣音的方式說話，通常會直接對著麥克風說話，讓聲音更貼近聽者。', 
    specialNotes: '可以想成是一種環境更加安靜的podcast。通常具有主題性，例如說故事、正能量語句複誦。', 
    category: 'Vocal & Mouth Sounds', 
    imageUrl: 'assets/whispering.png', 
    audioPath: 'audio/whispering.mp3', 
    videoPath: 'assets/video/whispering.mp4'
  ),
  AsmrItem(
    title: 'Mukbang (吃播)', 
    mainDescription: '咀嚼食物、清脆咬下的聲音。', 
    triggerType: '著重收音在咀嚼聲與吞嚥聲。', 
    specialNotes: '適合喜歡美食聲音的人。', 
    category: 'Vocal & Mouth Sounds', 
    imageUrl: 'assets/eating.png', 
    audioPath: 'audio/eating.mp3', 
    videoPath: 'assets/video/eating.mp4'
  ),
  AsmrItem(
    title: 'Hand Movements (手部運動)', 
    mainDescription: '在鏡頭前緩慢揮動手部，產生視覺放鬆感。', 
    triggerType: '雙手在鏡頭及麥克風周圍移動，配合手指間靈動的變化，也會搭配一些雙手間乾燥的摩擦聲。', 
    specialNotes: '通常是聲音及視覺上的雙重體驗。', 
    category: 'Visual Triggers', 
    imageUrl: 'assets/hand_movement.png', 
    audioPath: 'audio/hand_movement.mp3', 
    videoPath: 'assets/video/hand_movement.mp4',
  ),
  AsmrItem(
    title: 'Light Tracking (燈光追蹤)', 
    mainDescription: '用手電筒或筆燈引導視覺焦點。', 
    triggerType: '在鏡頭前緩慢亦或快速移動光源，讓光點在觀眾眼前來回移動，營造視覺上的放鬆與專注感。', 
    specialNotes: '常搭配follow the instruction主題，可以營造一種專注感。', 
    category: 'Visual Triggers', 
    imageUrl: 'assets/light_tracking.png', 
    audioPath: 'audio/light_tracking.mp3', 
    videoPath: 'assets/video/light_tracking.mp4'
  ),
  AsmrItem(
    title: 'Makeup Roleplay (化妝模擬)', 
    mainDescription: '模擬幫觀眾化妝、刷具掃過臉頰的聲音與視覺。', 
    triggerType: '拿化妝品在鏡頭前、人臉上、亦或直接刷在鏡頭上。', 
    specialNotes: '拍攝者通常會搭配一些美妝相關的對話內容提升沉浸感，例如幫觀眾選擇適合的粉底色號、或是模擬幫觀眾上妝的過程。Roleplay系列通常是其他分類的結合體。', 
    category: 'Roleplay & Personal Attention', 
    imageUrl: 'assets/makeup.png', 
    audioPath: 'audio/makeup.mp3', 
    videoPath: 'assets/video/makeup.mp4'
  ),
  AsmrItem(
    title: 'Haircut Roleplay (理髮模擬)', 
    mainDescription: '模擬理髮師為觀眾剪髮、吹風與整理儀容的過程。',
    triggerType: '剪刀在耳邊的喀嚓聲、梳子刮過頭髮的白噪音、溫柔的人聲低語。',
    specialNotes: '適合極度需要放鬆心情，或是喜歡「頭皮發麻」酥癢感的人。Roleplay系列通常是其他分類的結合體。',
    category: 'Roleplay & Personal Attention', 
    imageUrl: 'assets/haircut.png',
    audioPath: 'audio/haircut.mp3', 
    videoPath: 'assets/video/haircut.mp4', 
  ),
];

/// --- 第一頁：進入頁面 (動態啟動頁) ---
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentStep = 0; // 控制目前顯示到第幾個字母

  @override
  void initState() {
    super.initState();
    _startAnimationAndNavigate();
  }

  // 控制動畫與自動跳轉的流程
  Future<void> _startAnimationAndNavigate() async {
    // 1. 讓 A、S、M、R 依序漸入出現 (每隔 0.5 秒出現一個)
    for (int i = 1; i <= 4; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _currentStep = i;
        });
      }
    }

    // 2. 字母全部出現後，停頓 1.5 秒讓使用者看清楚
    await Future.delayed(const Duration(milliseconds: 1500));

    // 3. 自動跳轉到總覽頁
    if (mounted) {
      Navigator.pushReplacement( // 使用 pushReplacement 替換頁面，避免返回鍵回到封面
        context,
        MaterialPageRoute(builder: (context) => const OverviewPage()),
      );
    }
  }

  // 獨立抽出的 Widget：用來產生帶有漸入動畫的單一字母
  Widget _buildAnimatedLetter(String letter, int step) {
    return AnimatedOpacity(
      // 如果目前的進度 >= 這個字母的順序，透明度就是 1 (完全顯示)，否則為 0 (隱藏)
      opacity: _currentStep >= step ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800), // 漸入的動畫時間 (0.8秒)
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          letterSpacing: 8,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedLetter('A', 1),
            _buildAnimatedLetter('S', 2),
            _buildAnimatedLetter('M', 3),
            _buildAnimatedLetter('R', 4),
          ],
        ),
      ),
    );
  }
}

// --- 第二頁：ASMR 概述與分類 Grid (Wireframe 2 + 滿足 GridView 要求) ---
// 🌟 改為 StatefulWidget 才能控制方框的顯示狀態
class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  // 🌟 用來記錄方框是否顯示的變數，預設為 false (隱藏)
  bool _isInfoVisible = false;

  // 絕對左側位置，完美避開中央麥克風
  static const List<Map<String, dynamic>> _panelData = [
    {'index': 0, 'leftPercent': 0.09}, // Physics
    {'index': 1, 'leftPercent': 0.23}, // Vocal
    {'index': 2, 'leftPercent': 0.67}, // Visual
    {'index': 3, 'leftPercent': 0.81}, // Roleplay
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1A3F),
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover, 
          alignment: Alignment.center,
          child: SizedBox(
            width: 1000,
            height: 1800,
            child: Stack(
              children: [
                // ==========================================
                // 1. 底層背景圖
                // ==========================================
                Image.asset(
                  'assets/asmr_main_bg.png',
                  width: 1000,
                  height: 1800,
                  fit: BoxFit.fill,
                ),

                // ==========================================
                // 2. 獨立定位的透明按鈕
                // ==========================================
                for (var panel in _panelData)
                  Positioned(
                    top: 1800 * 0.32,    
                    left: 1000 * (panel['leftPercent'] as double),
                    width: 1000 * 0.11,  
                    height: 1800 * 0.35, 
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => MainTabPage(initialIndex: panel['index'] as int),
                           ),
                         );
                      },
                      child: Container(color: Colors.white.withOpacity(0.1)),
                    ),
                  ), 

                // ==========================================
                // 3. 🌟 新增：麥克風的專屬點擊感應區
                // ==========================================
                Positioned(
                  top: 1800 * 0.40, // 抓大約麥克風頭部的高度
                  left: 1000 * 0.38, // 放在 Vocal 和 Visual 中間
                  width: 1000 * 0.24, // 寬度剛好罩住麥克風
                  height: 1800 * 0.30, 
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // 點下去就切換狀態：開變關、關變開
                        _isInfoVisible = !_isInfoVisible;
                      });
                    },
                
                    child: Container(color: Colors.transparent), 
                  ),
                ),

                // ==========================================
                // 4. 🌟 ASMR 概述文字框 (加上顯示條件與點擊關閉功能)
                // ==========================================
                if (_isInfoVisible) // 只有當變數為 true 時才畫出這個方框
                  Positioned(
                    bottom: 80, 
                    left: 80,   
                    right: 80,
                    child: GestureDetector(
                      // 點擊方框本身也能關閉它，操作更順手
                      onTap: () => setState(() => _isInfoVisible = false),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3), // 你的新樣式
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.4),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // 讓 Column 高度自動貼合文字，避免跑版
                          children: [
                            const Text(
                              'Autonomous Sensory Meridian Response ?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 48, 
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '一種由視覺、聽覺或觸覺刺激所引發的感受。\n透過細微的聲音與動作，幫助你放鬆身心、緩解壓力。\n點擊上方四個分類，帶你進入ASMR的世界。',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 32,
                                height: 1.6, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- 第三頁：四大分類 Tab 頁面 (Wireframe 3) ---
class MainTabPage extends StatelessWidget {
  final int initialIndex;
  const MainTabPage({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    // 9. 使用 DefaultTabController、TabBar、TabBarView 製作 tab 分頁
    return DefaultTabController(
      length: 4,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('ASMR 分類'),
          bottom: const TabBar(
            isScrollable: true, // 讓字太長時可以左右滑動
            tabs: [
              Tab(text: 'Physical'),
              Tab(text: 'Vocal'),
              Tab(text: 'Visual'),
              Tab(text: 'Roleplay'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryListView(category: 'Physical & Object Sounds'),
            CategoryListView(category: 'Vocal & Mouth Sounds'),
            CategoryListView(category: 'Visual Triggers'),
            CategoryListView(category: 'Roleplay & Personal Attention'),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 抽取出來的分類頁面 (改為 GridView 網格排版)
// ==========================================
class CategoryListView extends StatelessWidget {
  final String category;
  const CategoryListView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // 過濾出該分類的資料
    final items = dummyData.where((item) => item.category == category).toList();

    // 改用 GridView.builder 來做兩欄式的排版
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,           // 設定為兩排 (兩欄)
        crossAxisSpacing: 16,        // 左右卡片的間距
        mainAxisSpacing: 16,         // 上下卡片的間距
        childAspectRatio: 0.8,       // 卡片的寬高比例 (數字越小卡片越長，可以依喜好微調)
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AsmrItemTile(item: items[index]);
      },
    );
  }
}

// ==========================================
// 5. 自訂的 StatefulWidget (上圖下文的卡片設計)
// ==========================================
class AsmrItemTile extends StatefulWidget {
  final AsmrItem item;
  const AsmrItemTile({super.key, required this.item});

  @override
  State<AsmrItemTile> createState() => _AsmrItemTileState();
}

class _AsmrItemTileState extends State<AsmrItemTile> {
  // 保留原本的獨立播放器邏輯
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // 監聽播放完成事件，自動跳回喇叭圖示
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // 播放與暫停切換
  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.item.audioPath!));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 因為 GridView 本身有 spacing，這裡就不需要外層的 Padding 了
    return Card(
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias, // 讓圖片完美貼合卡片圓角
      child: InkWell(
        onTap: () {
          // 點擊進入詳情頁時自動暫停
          if (_isPlaying) {
            _audioPlayer.pause();
            setState(() => _isPlaying = false);
          }
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(item: widget.item),
            ),
          );
        },
        // 重新排版：改用 Column (上圖、下文字)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 上半部：圖片 ---
            // 使用 Expanded 讓圖片盡可能填滿剩餘空間
            Expanded(
              child: Image.asset(
                widget.item.imageUrl, 
                fit: BoxFit.cover,
              ),
            ),
            
            // --- 下半部：名稱與預覽喇叭 ---
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 12.0, right: 4.0, top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左側名稱 (用 Expanded 避免名字太長破版)
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: const TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // 限制一行
                      overflow: TextOverflow.ellipsis, // 太長變刪節號
                    ),
                  ),
                  // 右側喇叭按鈕
                  if (widget.item.audioPath != null)
                    IconButton(
                      padding: EdgeInsets.zero,      // 縮小按鈕自帶的內邊距
                      constraints: const BoxConstraints(), // 讓按鈕可以更緊湊
                      iconSize: 28,
                      color: Colors.blue[600],
                      icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.volume_up_rounded),
                      onPressed: _togglePlay,
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

// --- 第四頁：子項目詳情頁面 ---
class DetailPage extends StatefulWidget {
  final AsmrItem item;
  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.item.videoPath != null && widget.item.videoPath!.isNotEmpty) {
      _videoController = VideoPlayerController.asset(widget.item.videoPath!)
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) => print("影片載入失敗: $error"));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🌟 將資料清單整理在 build 函式頂部，讓底下的 UI 結構更乾淨
    final infoData = [
      {'title': '📖 主要說明', 'content': widget.item.mainDescription},
      {'title': '✨ 呈現方式', 'content': widget.item.triggerType},
      {'title': '💡 補充與特別處', 'content': widget.item.specialNotes},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 稍微偏暖的紙張底色
      appBar: AppBar(
        title: Text(widget.item.category),
        backgroundColor: Colors.brown[800],
        foregroundColor: Colors.white,
      ), 
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. (PIC) 大圖
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.item.imageUrl, 
                height: 220, 
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            
            // 2. (Name) 子項名
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // 3. 🌟 使用 ListView.separated 滿足老師需求
            ListView.separated(
              shrinkWrap: true, // 讓 ListView 適應內容高度
              physics: const NeverScrollableScrollPhysics(), // 禁用內層滑動，統一由外層的 SingleChildScrollView 滑動
              itemCount: infoData.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // 每個框框之間的間距
              itemBuilder: (context, index) {
                // 🌟 使用自訂的 StatelessWidget 顯示資料
                return InfoBoxTile(
                  title: infoData[index]['title']!,
                  content: infoData[index]['content']!,
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // 4. 🎥 影片區塊
            if (_videoController != null) 
              _videoController!.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play();
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            ),
                            if (!_videoController!.value.isPlaying)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
                              ),
                          ],
                        ),
                      ),
                    )
                  // 🌟 加上 SizedBox 固定高度，防止影片載入瞬間畫面跳動
                  : const SizedBox(
                      height: 200, 
                      child: Center(child: CircularProgressIndicator()),
                    )
            else
              const Card(
                color: Color(0xFFF5EEDC),
                child: SizedBox(width: double.infinity, height: 100, child: Center(child: Text('目前沒有輔助影片 🎬', style: TextStyle(color: Colors.black54)))),
              ),
              
            const SizedBox(height: 40), // 底部留白
          ],
        ),
      ),
    );
  }
}

// ==========================================
// StatelessWidget (用來顯示 ListView 裡的每一個資訊框)
// ==========================================
class InfoBoxTile extends StatelessWidget {
  final String title;
  final String content;

  const InfoBoxTile({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.brown[300]!, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.brown[800])),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87)),
        ],
      ),
    );
  }
}