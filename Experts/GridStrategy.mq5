//+------------------------------------------------------------------+
//|                                                 GridStrategy.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade/Trade.mqh>



CTrade Trading;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {


   
  }







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
