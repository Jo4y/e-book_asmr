🎧 ASMR 沉浸式音影電子書 (ASMR e-Book)
這是一個專為放鬆與睡眠設計的 Flutter 行動應用程式。透過精緻的視覺場景與豐富的影音互動，帶領使用者探索 ASMR（自主感覺經絡反應）的世界。本專案不僅美觀，更完整實作了多項 Flutter 核心元件與多媒體播放技術。

📸 畫面預覽 (App Screenshots)
<div align="center">
  <img src="assets/screenshots/a.png" width="30%" alt="歡迎與總覽頁面" />
  <img src="assets/screenshots/b.png" width="30%" alt="分類網格頁面" />
  <img src="assets/screenshots/c.png" width="30%" alt="子項目詳情頁面" />
  <p><i>(由左至右：全屏導覽場景、兩欄式分類網格、影音詳情介紹頁)</i></p>
</div>

✨ 核心功能 (Features)
動態啟動動畫：字母 A-S-M-R 依序漸入出現，營造沉浸式開場氛圍。

全景霓虹導覽頁：使用 Stack 佈局與透明感應區，讓使用者在手繪麥克風場景中直接點擊文字進入分類。

四大 ASMR 分類：包含 Physical, Vocal, Visual 與 Roleplay 四大主流領域，使用 Tab 系統進行流暢切換。

兩欄式網格列表：美觀的 GridView 佈局，展示項目縮圖並支援一鍵快速預覽音效。

影音雙棲詳情頁：

結構化說明：使用 ListView.separated 展示條理分明的功能介紹。

實境影片播放：支援點擊畫面播放/暫停，並提供自動隱藏的播放提示 UI。

音影自動重設：音檔播放結束自動重設圖示，進入詳情頁自動暫停預覽。

🛠️ 技術實作 (Technical Requirements)
本專案完美符合課程開發需求，包含：

[x] 多頁面切換：使用 Navigator 進行頁面跳轉與重置。

[x] 資料模型化：定義 AsmrItem 型別管理複雜的影音與文字資料。

[x] 高效列表渲染：實作 ListView.builder 與 ListView.separated。

[x] 網格佈局：使用 GridView.builder 達成兩兩並排的卡片設計。

[x] 分頁導航：完整實作 DefaultTabController 與 TabBarView。

[x] 點擊偵測：靈活運用 GestureDetector 與 InkWell 處理不同層級的點擊事件。

[x] 狀態管理：使用 StatefulWidget 與 setState 精準控制影音播放狀態。

[x] 原生優化：自訂專屬 App Icon 並優化不同頁面的系統狀態列 (StatusBar) 顏色。

📂 專案結構說明
AsmrItem：自訂資料型別，儲存標題、分類、多種介紹文字、圖片路徑、影音路徑。

WelcomePage：啟動動畫頁面。

OverviewPage：全屏 Stack 導覽頁面。

MainTabPage：分類 Tab 主頁面。

CategoryListView：負責渲染各分類的 Grid 網格。

DetailPage：細項介紹與影片播放頁面。

InfoBoxTile：自訂 StatelessWidget 用於詳情頁列表。

📝 操作提示
在總覽頁點擊麥克風，可以彈出 ASMR 的知識科普方框。

在列表中點擊藍色喇叭圖示，可以在進入內頁前快速試聽。

在詳情頁點擊影片畫面任何位置，即可隨時暫停或繼續播放。