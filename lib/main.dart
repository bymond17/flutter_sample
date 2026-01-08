import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Sample',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // 새로운 단어쌍을 생성하고 상태 변경 알림
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current; // 현재 단어쌍을 변수로 추출 (BigCard 위젯에 전달하기 위해)

    return Scaffold(
      body: Center( // 화면 중앙에 위젯 배치
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로축 중앙 정렬
          children: [
            Text('A random AWESOME idea:'),
            BigCard(pair: pair), // BigCard 위젯으로 추출하여 재사용 가능하게 변경
        
            ElevatedButton(
              onPressed: () {
                appState.getNext(); // 버튼 클릭 시 새로운 단어쌍 생성
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

// 단어쌍을 카드 형태로 표시하는 커스텀 위젯 (위젯 추출로 생성됨)
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair, // 표시할 단어쌍을 외부에서 전달받음
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 현재 테마 정보를 가져옴
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    ); // 텍스트 스타일 설정 (큰 글씨 + 테마의 onPrimary 색상)

    // Card 위젯으로 배경색과 그림자 효과 추가
    return Card(
      color: theme.colorScheme.primary, // 카드 배경색은 테마의 primary 색상
      child: Padding(
        padding: const EdgeInsets.all(20), // 카드 내부에 20픽셀 여백
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}", // 접근성 레이블 설정
        ), // 단어쌍을 소문자로 표시
      ),
    );
  }
}
