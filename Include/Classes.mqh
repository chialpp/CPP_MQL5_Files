//+------------------------------------------------------------------+
//|                                                      Classes.mqh |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+


class CGrids
{
public :
   
   double reference_point;
   double grid_price;
   double grid_arr[];
   int grid_arr_size;
   
   
bool arr_resize(double &arr[], int new_size) {
    if (ArrayResize(arr, new_size)) {
        return true; // Resizing succeeded
    } else {
        Print("Error: ArrayResize failed!");
        return false; // Resizing failed
    }
}
  
 

double generat_one_higher_grid(string Symboll, double points)
   {
      return (SymbolInfoDouble(Symboll,SYMBOL_ASK)+points);

   }
   
double generat_one_lower_grid(string Symboll, double points)
   {
      return (SymbolInfoDouble(Symboll,SYMBOL_BID)-points);

   }
   
    
      
};
  