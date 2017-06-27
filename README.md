# MQL4-File
MQL4でファイルを扱うためのモジュール。


## Install
1. File.mqhとenums.mqhをダウンロード
2. データフォルダを開き、/MQL4/Includes/mql4_modules/File/配下に2つのファイルを保存


## Usage
File.mqhをincludeして利用する。  

### Copy  
ファイルのコピー
```cpp
// MQL4/Files内のhoge.txtを複製したuga.txtを作成
File::Copy("hoge.txt", "uga.txt");
```

### Delete  
ファイルの削除
```cpp
// MQL4/Files内のhoge.txtを削除
File::Delete("hoge.txt");
```

### Move  
ファイルを移動
移動範囲はMQL4/Filesフォルダ内に制限
```cpp
// MQL4/Files内のhoge.txtをuga.txtとして保存
File::Move("hoge.txt", "uga.txt");
```

### MoveEx
ファイルの移動
MQL4/Filesフォルダ外のファイル移動が可能
```cpp
// MQL4/Files/hoge.txtをMQL4/Experts/hoge.txtへと移動
string path1 = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL4\\Files\\hoge.txt";
string path2 = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL4\\Experts\\hoge.txt";
File::MoveEx(path1, path2);
```

### Read
ファイルの中身を読み込み
```cpp
// MQL4/Files/hoge.txtの中身を読み取って変数へ保存
string value = File::Read("hoge.txt");
```

### Write
ファイルへ書き込み
```cpp
// MQL4/Files/hoge.txtに「hoge」と書き込む
string text = "hoge";
File::Write("hoge.txt", text);
```
