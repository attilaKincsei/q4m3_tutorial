\p 5042

adjDate:{[dt] 0 -1 0i+`year`mm`dd$dt}; / 2015.01.01 -> 2015 0 1i

getHist:{[ticker; sdt; edt]
  tmpl:"http://ichart.finance.yahoo.com/table.csv?s=",
        "%tick&d=%em&e=%ed&f=%ey&g=d&a=%sm&b=%sd&c=%sy";
  args:string ticker,raze adjDate each (sdt;edt);
  url:ssr/[tmpl; ("%tick";"%sy";"%sm";"%sd";"%ey";"%em";"%ed"); args];
  raw:system "wget -q -O - ",url;
  t:("DFFFFJF"; enlist ",") 0: raw;
  `Date xasc `Date`Open`High`Low`Close`Volume`AdjClose xcol t}

getData:{[ticker; sdt] select Date,Close from getHist[`$ticker;"D"$sdt;.z.D]}

.z.ws:{
  args:(-9!x) `payload;
  neg[.z.w] -8!(enlist `hist)!enlist .[getData; args; `err]}