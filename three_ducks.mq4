// Three Ducks

// A technique developed by Captain Currency
// Discussion thread
// http://www.trade2win.com/boards/forex/123288-3-ducks-trading-system-413.html

// Author
// Terrence Brannon
// http://iwantyoutoprosper.com/income/transient/forex-transient/three-ducks-ea

#property copyright ""
#property link      "http://iwantyoutoprosper.com/income/transient/forex-transient/three-ducks-ea"


string TradeCode="THREE_DUCKS_1.0";
double H4_SMA,H1_SMA,M5_SMA;
string H4_direction;
bool H1_confirms_H4;
double high;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {

   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {

   ObjectsDeleteAll();
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {

   H1_confirms_H4=false;
   calculate_moving_averages();
   determine_and_confirm_direction();
   Print("H4 direction",H4_direction);
   Print("H1 confirms",H1_confirms_H4);

   return(0);

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+-------------------------General Functions------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

int calculate_moving_averages()
  {

   int averaging_period=60;
   int ma_shift=0;
   int shift= 0;
   int mode = MODE_SMA;
   int applied_price=PRICE_CLOSE;

   H4_SMA = iMA(Symbol(), PERIOD_H4, averaging_period, ma_shift, mode, applied_price, shift);
   H1_SMA = iMA(Symbol(), PERIOD_H1, averaging_period, ma_shift, mode, applied_price, shift);
   M5_SMA = iMA(Symbol(), PERIOD_M5, averaging_period, ma_shift, mode, applied_price, shift);

   ObjectCreate("H4_SMA",OBJ_TEXT,0,Time[10],H4_SMA);
   ObjectSetText("H4_SMA","H4 SMA",14,"Tahoma",Gold);

   ObjectCreate("H1_SMA",OBJ_TEXT,0,Time[10],H1_SMA);
   ObjectSetText("H1_SMA","H1 SMA",14,"Tahoma",Blue);

   return(0);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int determine_and_confirm_direction()
  {

   Print("H4 SMA= ",H4_SMA,"BID = ",Bid);
   Print("H1 SMA= ",H1_SMA,"BID = ",Bid);

   if(H4_SMA>Bid)
     {
      H4_direction="sell";
      if(H1_SMA>Bid)
        {
         H1_confirms_H4=true;
         draw_low();
        }
     }

   if(H4_SMA<Bid)
     {
      H4_direction="buy";
      if(H1_SMA<Bid)
        {
         H1_confirms_H4=true;
         draw_high();
        }
     }

   if(H4_SMA==Bid)
      H4_direction="nothing";

   LabelCreate(0,"TWO_DUCKS",0,0,30,CORNER_LEFT_UPPER,"2 ducks say "+H4_direction,"Arial",14);

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int draw_high()
  {

   for(int i=2; i<999;++i)
     {
      double bar_max=MathMax(Open[i],Close[i]);
      if(bar_max>M5_SMA)
        {
         high=bar_max;
         int window_number=0;
         ObjectCreate("high_line",OBJ_HLINE,window_number,Time[i],high);
         break;
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int draw_low()
  {

   for(int i=2; i<999;++i)
     {
      double bar_max=MathMin(Open[i],Close[i]);
      if(bar_max<M5_SMA)
        {

         high=bar_max;
         int window_number=0;
         ObjectCreate("high_line",OBJ_HLINE,window_number,Time[i],high);
         break;
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//| Create a text label                                              |
//+------------------------------------------------------------------+
bool LabelCreate(const long              chart_ID=0,               // chart's ID
                 const string            name="Label",             // label name
                 const int               sub_window=0,             // subwindow index
                 const int               x=0,                      // X coordinate
                 const int               y=0,                      // Y coordinate
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                 const string            text="Label",             // text
                 const string            font="Arial",             // font
                 const int               font_size=10,             // font size
                 const color             clr=clrRed,               // color
                 const double            angle=0.0,                // text slope
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                 const bool              back=false,               // in the background
                 const bool              selection=false,          // highlight to move
                 const bool              hidden=true,              // hidden in the object list
                 const long              z_order=0)                // priority for mouse click
  {
//--- reset the error value
   ResetLastError();
//--- create a text label
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": failed to create text label! Error code = ",GetLastError());
      return(false);
     }
//--- set label coordinates
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- set the text
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }

//+------------------------------------------------------------------+
