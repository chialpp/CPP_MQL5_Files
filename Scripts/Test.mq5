//+------------------------------------------------------------------+
//|                                                         Test.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
  
   //Alert("The Base Currency is: "+ SymbolInfoString(_Symbol, SYMBOL_CURRENCY_BASE) );
   //Alert("The Profit Currency is: "+ SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT) );
   //Alert("The Margin Currency is: "+ SymbolInfoString(_Symbol, SYMBOL_CURRENCY_MARGIN) );
   //Alert("The Accuont  Currency is: "+ AccountInfoString(ACCOUNT_CURRENCY));
   //AccountInfoDouble(ACCOUNT_BALANCE)
   ///Alert("Lot size is: "+ SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));
   //Alert("The tick value is equalto: "+SymbolInfoDouble(AccountInfoString(ACCOUNT_CURRENCY)+SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT),SYMBOL_BID));
   
   
   MqlTradeResult result={}; 
   MqlTradeRequest request={};
   double EntryPoint=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   request.action=TRADE_ACTION_DEAL;
   request.symbol=Symbol();
   request.volume=OptimumVolumeSize(EntryPoint,EntryPoint-200*Point(),0.01);
   request.sl=EntryPoint-200*Point();
   //request.tp=askPrice+300*Point();
   request.type=ORDER_TYPE_BUY;
   request.price=EntryPoint;///SymbolInfoDouble(Symbol(),SYMBOL_ASK);
  
   OrderSend(request,result);
   Alert("Valume is equal to: "+ request.volume);
   
  
  }




void send_order(double EntryPoint, double StopLoss, double RiskPercent)
{
   MqlTradeResult result={}; 
   MqlTradeRequest request={};
   //double askPrice = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
   //double bidPrice = SymbolInfoDouble(Symbol(), SYMBOL_BID); 
   
   request.action=TRADE_ACTION_DEAL;
   request.symbol=Symbol();
   request.volume=1;
   request.sl=StopLoss;
   //request.tp=askPrice+300*Point();
   request.type=ORDER_TYPE_BUY;
   request.price=EntryPoint;///SymbolInfoDouble(Symbol(),SYMBOL_ASK);
  
   OrderSend(request,result);
   

} 


double OptimumVolumeSize(double EntryPoint, double StopLoss, double RiskPercent)
{
   double MaxAllowedEquityLoss=RiskPercent*AccountInfoDouble(ACCOUNT_EQUITY);
   double VolumeSize;
   
   /// When the quote currency is Dollar
   
   if(SymbolInfoString(_Symbol,SYMBOL_CURRENCY_PROFIT)==AccountInfoString(ACCOUNT_CURRENCY))
   {
      VolumeSize =  MaxAllowedEquityLoss/(MathAbs(EntryPoint-StopLoss));
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==0.01) VolumeSize=VolumeSize/100000;
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==1.0) VolumeSize=VolumeSize;  

   }
   
   if(SymbolInfoString(_Symbol,SYMBOL_CURRENCY_BASE)==AccountInfoString(ACCOUNT_CURRENCY))
   {
      double Ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
      VolumeSize=MaxAllowedEquityLoss*Ask/(MathAbs(EntryPoint-StopLoss));
      
      
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==0.01) VolumeSize=VolumeSize/100000;
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==1.0) VolumeSize=VolumeSize;  

   }
   
   
   
   
   if((SymbolInfoString(_Symbol,SYMBOL_CURRENCY_PROFIT)!=AccountInfoString(ACCOUNT_CURRENCY)) && (SymbolInfoString(_Symbol,SYMBOL_CURRENCY_BASE)!=AccountInfoString(ACCOUNT_CURRENCY)))
   {
      double Tickvalue=SymbolInfoDouble(SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT)+AccountInfoString(ACCOUNT_CURRENCY),SYMBOL_BID);
      
      if (Tickvalue==0.0)
      {
         Tickvalue=1/(SymbolInfoDouble(AccountInfoString(ACCOUNT_CURRENCY)+SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT),SYMBOL_BID));
      }
      
      VolumeSize =  MaxAllowedEquityLoss*Tickvalue/(MathAbs(EntryPoint-StopLoss));
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==0.01) VolumeSize=VolumeSize/100000;
      if (SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN)==1.0) VolumeSize=VolumeSize; 
   }
   
   
   
  

 return NormalizeDouble( VolumeSize,2);

}
