three_ducks
===========

The following is MT4 code for the 3 Ducks Trading System. It makes
finding the 3 ducks simpler. Instead of having to manually setup three
moving averages and calculate the high price, it does all that for
you.

# Overview

The 3 Ducks system recommends a trade when you have 3 ducks in a
line. Duck 1 is the 60-period H4 SMA. If this SMA is below the current
price, duck 1 suggests buy. If it is below duck 1 suggests sell.

Duck 2 is the 60-period H1 SMA. If this SMA is on the same side of the
current price as duck 1, then you have 2 ducks in a line. In other
words, duck 2 may or may not confirm duck 1.

In the image below we see 4 examples of 2 ducks in a line.
![](https://www.evernote.com/shard/s309/sh/1b0eea98-5276-4f8b-bef5-b402ec42517b/f6f1e2e066f750124faae167493e615d/deep/0/Screenshot%206/20/14,%2012:38%20AM.jpg).
It
is possible for the 2 ducks to suggest nothing, and the indicator will
say that if it is so.

Duck 3 is an SMA-breakout line. The SMA-breakout line is calculated as
follows in a buy condition:

1. start at the current bar (the rightmost bar). This is called Bar Zero.
2. move rightwards to Bar 1 (one bar over).
2. Now, move rightwards to the first bar whose MAX(open, close) is higher
than the M5 SMA. This means the first possible bar to use will be the
third bar.
3. draw this line as the SMA-breakout line

The same logic applies to a sell position. Except we use `MIN(open,
close)` and we will trade when it is lower than the SMA-breakout line.

In ![the image
below](https://www.evernote.com/shard/s309/sh/b2d67a9e-5d7d-472a-8537-ea03f2a677e5/ceb4a94cfdd2677613c97a860505c0a3/deep/0/Screenshot%206/20/14,%2012:58%20AM.jpg)
we see the M5 60-period SMA in violet. The first qualifying bar for
below this SMA is the third bar and you can see the red line is drawn
through the open of that bar.

![Here is a
 closeup](https://www.evernote.com/shard/s309/sh/aef29a5b-e4eb-43a8-978c-b47e94f1d6be/7b0b6d722125d4372d20bf8de247542b/deep/0/Screenshot%206/20/14,%2012:59%20AM.jpg)
 showing that the red line is drawn through the open of the third bar.


# Installation

Click on "Download zip" to the right. Unzip the file. Put
`three_ducks.mq4` in your MT4 installation's Experts directory.

Open a chart. Put the chart on M5 timeframe. Drag the expert to the chart.

# To Do

Plenty.

# Support / Contact

For support requests click on "Issues" to the right and fill out an
issue ticket.
