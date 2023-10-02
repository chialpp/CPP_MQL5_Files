//+------------------------------------------------------------------+
//|                                       EA_GridTradingStrategy.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Most_Common_Classes.mqh>




input int GridDistancePoint=400;
double high_grid;
double low_grid;
double balance_grid;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

      double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
      Trading.Buy(1,_Symbol,ask);
      
      balance_grid=ask;
      high_grid=next_higer_grid(balance_grid,GridDistancePoint);       
      low_grid=next_lower_grid(balance_grid,GridDistancePoint);


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
      MqlDateTime  TimeStructure;   
      datetime timee=TimeCurrent();
      TimeToStruct(timee,TimeStructure);

      double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
         
      // if (TimeStructure.day_of_week == 5 && PositionsTotal()!=0) {close_All_Orders();}   
         
      if(ask>high_grid && TimeStructure.day_of_week != 5)
      {
         // Close one Buy
         //close_oldest_buy(_Symbol);
         
         // Open a buy and Sell
         //Trading.Buy(1,_Symbol);
         Trading.Sell(1,_Symbol);
         
         balance_grid=ask;
         high_grid=next_higer_grid(balance_grid,GridDistancePoint);       
         low_grid=next_lower_grid(balance_grid,GridDistancePoint);
         
      
      } 
      
      
      
      if(bid<low_grid && TimeStructure.day_of_week != 5)
      {
         // Close one Sell
         //close_oldest_Sell(_Symbol);
         
         // Open a buy and Sell
         Trading.Buy(1,_Symbol);
         //Trading.Sell(1,_Symbol);
         
         balance_grid=bid;
         high_grid=next_higer_grid(balance_grid,GridDistancePoint);       
         low_grid=next_lower_grid(balance_grid,GridDistancePoint);
         
      
      }               
      
   
  }





///////////////////////////////////////////////////////////////////
////////////////////////Functiones/////////////////////////////////
//////////////////////////////////////////////////////////////////





double next_higer_grid(double EntryPrice,int PointDictence)
{
      return EntryPrice+PointDictence*Point();
}

double next_lower_grid(double EntryPrice,int PointDictence)
{
      return EntryPrice-PointDictence*Point();
}


////////////////////////////////////////////////////////////////////////////

void close_oldest_buy(string Symboll)
{
   bool t;   
   for (int i=0;i<PositionsTotal();i++)
   {
      PositionSelectByTicket(PositionGetTicket(i));

      if(PositionGetString(POSITION_SYMBOL)==Symboll && PositionGetInteger(POSITION_TYPE)==0) 
      {
      //Positionn.SelectByIndex(i);
      do
      {
      t=Trading.PositionClose(PositionGetInteger(POSITION_TICKET));
      }while(!t);
      break;
      }
      
   }

}

////////////////////////////////////////////////////////////////////////////////

void close_oldest_Sell(string Symboll)
{
   bool t;
   for (int i=0;i<PositionsTotal();i++)
   {
      PositionSelectByTicket(PositionGetTicket(i));

      if(PositionGetString(POSITION_SYMBOL)==Symboll && PositionGetInteger(POSITION_TYPE)==1) 
      {
      //Positionn.SelectByIndex(i);
      do
      {
      t=Trading.PositionClose(PositionGetInteger(POSITION_TICKET));
      }while(!t);
      break;
      }
      
   }

}

