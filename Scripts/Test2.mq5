//+------------------------------------------------------------------+
//|                                                        Test2.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>


CTrade Trading;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   
   
      double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
      double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
      double lot;
      lot=OptimumLotSize(Symbol(),ask,ask-100*Point(),0.05);
      bool confirmation=Trading.Sell(lot,Symbol(),bid,bid+100*Point(),bid-300*Point());
     
      Comment("the  Currency is: "+ confirmation);
   
    
      
   
  }



double OptimumLotSize(string symbol,double EntryPoint, double StoppLoss, double RiskPercent)
{
      int            Diigit         =SymbolInfoInteger(symbol,SYMBOL_DIGITS);
      double         OneLotValue    =MathPow(10,Diigit);
      double         ask            =SymbolInfoDouble(symbol,SYMBOL_ASK);
      double         bid            =SymbolInfoDouble(symbol,SYMBOL_BID);
      
      string         BaseCurrency   =SymbolInfoString(symbol,SYMBOL_CURRENCY_BASE);
      string         ProfitCurency  =SymbolInfoString(symbol,SYMBOL_CURRENCY_PROFIT); 
      string         AccountCurency =AccountInfoString(ACCOUNT_CURRENCY);
      
      double         AllowedLoss    =RiskPercent*AccountInfoDouble(ACCOUNT_EQUITY);
      double         LossPoint      =MathAbs(EntryPoint-StoppLoss);
      double         Lotsize;
      
      
      
      
      
      if (ProfitCurency=="JPY") 
         { 
         Lotsize=AllowedLoss*1.5/LossPoint; 
         Lotsize=NormalizeDouble(Lotsize/OneLotValue,2);
          
         return(Lotsize); 
         }
         
         return(0); 

}