//+------------------------------------------------------------------+
//|                                           Most_Common_Classes.mqh|
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>

CTrade Trading;

void close_All_Orders()
{
      do
      {
         PositionSelectByTicket(PositionGetTicket(0));
         Trading.PositionClose(PositionGetInteger(POSITION_TICKET));   
      }while(PositionsTotal()!=0);     

}





double OptimumLotSize(string symbol,double EntryPoint, double StoppLoss, double RiskPercent)
{
      int            Diigit         =SymbolInfoInteger(symbol,SYMBOL_DIGITS);
      double         OneLotValue    =MathPow(10,Diigit);
      
      double         ask            =SymbolInfoDouble("GBPUSD",SYMBOL_ASK);
      
      double         bid            =SymbolInfoDouble(symbol,SYMBOL_BID);
      
      string         BaseCurrency   =SymbolInfoString(symbol,SYMBOL_CURRENCY_BASE);
      string         ProfitCurency  =SymbolInfoString(symbol,SYMBOL_CURRENCY_PROFIT); 
      string         AccountCurency =AccountInfoString(ACCOUNT_CURRENCY);
      
      double         AllowedLoss    =RiskPercent*AccountInfoDouble(ACCOUNT_EQUITY);
      double         LossPoint      =MathAbs(EntryPoint-StoppLoss);
      double         Lotsize;
      
      
      
      
      
      if (ProfitCurency==AccountCurency) 
         { 
         Lotsize=AllowedLoss/LossPoint; 
         Lotsize=NormalizeDouble(Lotsize/OneLotValue,2);
          
         return(Lotsize); 
         }
         
      else if (BaseCurrency==AccountCurency)
         {
         AllowedLoss=ask*AllowedLoss;  //// Allowed loss in Profit currency Example: USDCHF-----> Return allowed loss in CHF
         Lotsize=AllowedLoss/LossPoint; 
         Lotsize=NormalizeDouble(Lotsize/OneLotValue,2); 
         return(Lotsize);
         }
      
         else
         {
            string TransferCurrency=AccountCurency+ProfitCurency;
            ask=SymbolInfoDouble(TransferCurrency,SYMBOL_ASK);
            
            if(ask!=0) 
            {
               AllowedLoss=ask*AllowedLoss;  //// Allowed loss in Profit currency Example: USDCHF-----> Return allowed loss in CHF
               Lotsize=AllowedLoss/LossPoint; 
               Lotsize=NormalizeDouble(Lotsize/OneLotValue,2); 
               return(Lotsize);   
            
            }
            else
            {
               TransferCurrency=ProfitCurency+AccountCurency;
               ask=SymbolInfoDouble(TransferCurrency,SYMBOL_ASK);
               ask=1/ask;
               AllowedLoss=ask*AllowedLoss;  //// Allowed loss in Profit currency Example: USDCHF-----> Return allowed loss in CHF
               Lotsize=AllowedLoss/LossPoint; 
               Lotsize=NormalizeDouble(Lotsize/OneLotValue,2); 
               return(Lotsize);
            
            }
            
            if (ProfitCurency=="JPY") 
               { 
               Lotsize=AllowedLoss*1.5/LossPoint; 
               Lotsize=NormalizeDouble(Lotsize/OneLotValue,2);
                
               return(Lotsize); 
               }
                  
         return Lotsize; 
         }
          

}
