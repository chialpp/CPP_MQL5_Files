//+------------------------------------------------------------------+
//|                                                  Script_Test.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Classes.mqh>
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>


CTrade Trading;
CPositionInfo Positionn;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
    close_All_Orders();
  
  }



void close_All_Orders()
{
   
      do
      {
         PositionSelectByTicket(PositionGetTicket(0));
         Trading.PositionClose(PositionGetInteger(POSITION_TICKET));   
      }while(PositionsTotal()!=0);     


}
