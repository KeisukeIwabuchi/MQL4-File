# MQL4-File
Module for handling files with MQL4.


## Install
1. Download File.mqh
2. Save the file to /MQL4/Includes/mql4_modules/File/File.mqh


## Usage
Include File.mqh and use it.

### Copy
Copies the original file from a local folder to another file
```cpp
// MQL4/Files内のhoge.txtを複製したuga.txtを作成
File::Copy("hoge.txt", "uga.txt");
```

### Delete
Deletes the file from a local folder.
```cpp
// MQL4/Files内のhoge.txtを削除
File::Delete("hoge.txt");
```

### Move
Moves or renames a file.
```cpp
// MQL4/Files内のhoge.txtをuga.txtとして保存
File::Move("hoge.txt", "uga.txt");
```

### MoveEx
Moves or renames a file. There is no restriction.
```cpp
// MQL4/Files/hoge.txtをMQL4/Experts/hoge.txtへと移動
string path1 = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL4\\Files\\hoge.txt";
string path2 = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL4\\Experts\\hoge.txt";
File::MoveEx(path1, path2);
```

### Read
Reads a string from a file.
```cpp
// MQL4/Files/hoge.txtの中身を読み取って変数へ保存
string value = File::Read("hoge.txt");
```

### Write
Writes the value of a string parameter into a TXT file.
```cpp
// MQL4/Files/hoge.txtに「hoge」と書き込む
string text = "hoge";
File::Write("hoge.txt", text);
```
