//+------------------------------------------------------------------+
//|                                             Optimum_Lot_Size.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property script_show_inputs
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>

CTrade Trading;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

input bool IsBuy=true;
input double StopLoss;
input double TakeProfit;
input double RiskPercent=0.01;
double LotSize; 
void OnStart()
  {   
      
      double temp_RiskPercent=RiskPercent;
      double Ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
      double Bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
       
      
      
      
      
      if(temp_RiskPercent>0.04) temp_RiskPercent=0.04;
      
      if (IsBuy && StopLoss !=0.0)
      {
         LotSize=OptimumLotSize(Symbol(),Ask,StopLoss,temp_RiskPercent);
         Trading.Buy(LotSize,Symbol(),Ask,StopLoss,TakeProfit);  
         
      }
      
      if (!IsBuy && StopLoss !=0.0)
      {
         LotSize=OptimumLotSize(Symbol(),Bid,StopLoss,temp_RiskPercent);
         Trading.Sell(LotSize,Symbol(),Bid,StopLoss,TakeProfit);  
      
      }
   
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
