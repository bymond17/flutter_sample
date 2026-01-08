# flutter_sample

codelabs의 첫 번째 Flutter 앱 학습

[codelabs > flutter-codelab-first](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=ko#0)

```mermaid
---
title: lib/main.dart
---
flowchart
    subgraph "MyApp"
        State("MyAppState")
    end

    Home("MyHomePage")
    Some("SomeWidget")
    Other("OtherWidget")
    
    MyApp --> Home
    Home --> Some
    Home --> Other

    Other -.->|watches & uses| State
```