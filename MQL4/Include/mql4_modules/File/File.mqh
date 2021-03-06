//+------------------------------------------------------------------+
//|                                                         File.mqh |
//|                                 Copyright 2017, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property strict
#property version "1.002"


#ifndef _LOAD_MODULE_FILE
#define _LOAD_MODULE_FILE


#import "Kernel32.dll"
   bool MoveFileExW(string &lpExistingFileName,
                    string &lpNewFileName,
                    int     dwFlags);
#import


#define MOVEFILE_REPLACE_EXISTING 0x1


/** Method of FileOpen */
enum FILE_OPEN
{
   READ  = 0,
   WRITE = 1
};


/** Class for file operation. */
class File
{
   public:
      static bool   Copy(const string path, const string destination);
      static bool   Delete(const string path);
      static bool   Move(const string path, const string destination);
      static bool   MoveEx(string path, string destination);
      static string Read(const string path);
      static bool   Write(const string path, const string text);
      
   private:
      static int  openHandle(const string path, 
                             const FILE_OPEN type = WRITE);
      static void closeHandle(const int handle);
};


/**
 * Copies the original file to another file.
 *
 * @param const string path         File name to copy.
 * @param const string destination  Result file name.
 *
 * @return bool  Returns true if successful, otherwise false.
 */
static bool File::Copy(const string path, const string destination)
{
   bool result = false;
   int  handle = File::openHandle(path, READ);
   
   if(handle != INVALID_HANDLE) {
      /** the copy file already exists. */
      File::closeHandle(handle);
      result = FileCopy(path, 0, destination, FILE_REWRITE);
   }
   
   return(result);
}


/**
 * Deletes the specified file in a local folder.
 *
 * @param const string path  File name.
 *
 * @return bool  Returns true if successful, otherwise false.
 */
static bool File::Delete(const string path)
{
   return(FileDelete(path));
}


/**
 * Reads a string from a file.
 * In case of failure returns empty string.
 *
 * @param const string path  File name.
 *
 * @return string  Read text(string).
 */
static string File::Read(const string path)
{
   int    str_size;
   string result = "";
   int    handle = File::openHandle(path, READ);
   int    count  = 0;

   if(handle == INVALID_HANDLE) return("");
      
   while(!FileIsEnding(handle)) {
      if(count > 0) result   += "\n";
      
      str_size  = FileReadInteger(handle, INT_VALUE);
      result   += FileReadString(handle, str_size);
      count++;
   }
   
   File::closeHandle(handle);
   
   return(result);
}


/**
 * Moves a file from a local folder.
 *
 * @param const string path         File name to move/rename.
 * @param const string destination  File name after operation.
 *
 * @return bool  Returns true if successful, otherwise false.
 */
static bool File::Move(const string path, const string destination)
{
   bool result = false;
   int  handle = File::openHandle(path, READ);
   
   if(handle != INVALID_HANDLE) {
      /** the copy file already exists. */
      File::closeHandle(handle);
      result = FileMove(path, 0, destination, FILE_REWRITE);
   }
   
   return(result);
}


/**
 * Moves a file.
 *
 * @param string path         File name to move/rename.
 * @param string destination  File name after operation.
 *
 * @return bool  Returns true if successful, otherwise false.
 */
static bool File::MoveEx(string path, string destination)
{
   return(MoveFileExW(path, destination, MOVEFILE_REPLACE_EXISTING));
}


/**
 * Writes the value of a string-type parameter.
 *
 * @param const string path  File name.
 * @param const string text  String.
 *
 * @return string   Returns true if successful, otherwise false.
 */
static bool File::Write(const string path, const string text)
{
   int  handle = File::openHandle(path);
   uint write  = 0;
   
   if(handle == INVALID_HANDLE) return(false);
   
   write = FileWriteString(handle, text);
   
   File::closeHandle(handle);
   
   return(write > 0);
}


/**
 * Opnes the file and returns the file handle.
 * In case of failure returns INVALID_HANDLE(= -1).
 *
 * @param const string path     File name.
 * @param const FILE_OPEN type  Method of file open.
 *  WRITE: FILE_WRITE|FILE_CSV
 *  READ:  FILE_READ|FILE_CSV
 *
 * @return int  Returns the file handle.
 */
static int File::openHandle(const string path, 
                            const FILE_OPEN type = WRITE)
{
   int handle = INVALID_HANDLE;
   
   switch(type) {
      case READ:
         handle = FileOpen(path, FILE_READ|FILE_CSV);
         break;
      case WRITE:
         handle = FileOpen(path, FILE_WRITE|FILE_CSV);
         break;
   }
   
   return(handle);
}


/**
 * Close the file previously opened by FileOpen().
 *
 * @param const int handle  File descriptor returned by FileOpen().
 */
static void File::closeHandle(const int handle)
{
   if(handle != INVALID_HANDLE) FileClose(handle);
}


#endif
