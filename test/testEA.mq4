//+------------------------------------------------------------------+
//|                                                         File.mqh |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property copyright   "Copyright 2017, Keisuke Iwabuchi"
#property link        "https://order-button.com/"
#property version     "1.00"
#property strict


#include <mql4_modules\File\File.mqh>


string file_path = "test.txt";
string file_text = "hoge";


int OnInit()
{
   /** test Write method */
   if(!File::Write(file_path, file_text)) {
      Print("Write method failed.");
      return(INIT_FAILED);
   }
   
   /** test Read method */
   string value = File::Read(file_path);
   if(value != file_text) {
      Print("Read method failed. value = ", value);
      return(INIT_FAILED);
   }
   
   /** test Copy method */
   string file_path_copy = "test_copy.txt";
   if(!File::Copy(file_path, file_path_copy)) {
      Print("Copy method failed.");
      return(INIT_FAILED);
   }
   value = File::Read(file_path_copy);
   if(value != file_text) {
      Print("Copy method invalid value. value = ", value);
      return(INIT_FAILED);
   }
   
   /** test Delete method */
   if(!File::Delete(file_path_copy)) {
      Print("Delete method failed.");
      return(INIT_FAILED);
   }
   if(FileIsExist(file_path_copy)) {
      Print(file_path_copy, " already exist.");
      return(INIT_FAILED);
   }
   
   /** test Move method */
   string file_path_move = "uga.txt";
   if(!File::Move(file_path, file_path_move)) {
      Print("Move method failed");
      return(INIT_FAILED);
   }
   if(File::Read(file_path_move) != file_text) {
      Print("Move method invalid value.");
      return(INIT_FAILED);
   }
   
   /** test MoveEx method */
   string data_path = TerminalInfoString(TERMINAL_DATA_PATH);
   string path_ex_1 = data_path + "\\MQL4\\Files\\" + file_path_move;
   string path_ex_2 = data_path + "\\MQL4\\Files\\" + file_path_move;
   if(!File::MoveEx(path_ex_1, path_ex_2)) {
      Print("MoveEx method failed");
      return(INIT_FAILED);
   }
   if(!File::MoveEx(path_ex_2, path_ex_1)) {
      Print("MoveEx method failed");
      return(INIT_FAILED);
   }
   
   /** test file delete */
   File::Delete(file_path_move);
   
   return(INIT_SUCCEEDED);
}


void OnTick()
{

}