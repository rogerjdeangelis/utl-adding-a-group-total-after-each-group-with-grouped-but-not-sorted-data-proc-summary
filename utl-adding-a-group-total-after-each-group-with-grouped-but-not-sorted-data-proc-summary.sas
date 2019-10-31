Fastest algorithm to add a group total after each group with grouped but not sorted data?

Proc summary is a mutithreaded and highly optimized procedure, so use it when you can.

github
https://tinyurl.com/y25k6lal
https://github.com/rogerjdeangelis/utl-adding-a-group-total-after-each-group-with-grouped-but-not-sorted-data-proc-summary

This is a an especially nice solution by data_null_
https://communities.sas.com/t5/user/viewprofilepage/user-id/15410

SAS Forum
https://communities.sas.com/t5/SAS-Programming/sum-of-values-column-wise/m-p/600324

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;
data have;
   input var $ var1 $ grp1 grp2 grp3;
cards4;
best A 3 4 6
best B 4 1 7
best C 1 3 1
Worst G 5 7 1
Worst E 5 2 6
;;;;
run;

 WORK.HAVE total obs=5

   VAR     VAR1    GRP1    GRP2    GRP3

  best      A        3       4       6
  best      B        4       1       7
  best      C        1       3       1
  Worst     G        5       7       1
  Worst     E        5       2       6

*           _
 _ __ _   _| | ___  ___
| '__| | | | |/ _ \/ __|
| |  | |_| | |  __/\__ \
|_|   \__,_|_|\___||___/

;

 WORK.HAVE total obs=5                   | Rules
                                         | Add group totals
   VAR     VAR1    GRP1    GRP2    GRP3  |
                                         |
  best      A        3       4       6   |
  best      B        4       1       7   |
  best      C        1       3       1   |

  best     Total     8       8      14     Add Column Sum for group

  Worst     G        5       7       1   |
  Worst     E        5       2       6   |
                                         |
  Worst    Total    10       9       7     Add Column Sum for group

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

WORKWANT total obs=7

   VAR     VAR1     GRP1    GRP2    GRP3

  best     A          3       4       6
  best     B          4       1       7
  best     C          1       3       1
  best     Total      8       8      14
  Worst    E          5       2       6
  Worst    G          5       7       1
  Worst    Total     10       9       7

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
proc format;
  value $var2tot
  " "="Total";
run;quit;

proc summary chartype descendtypes /* nice put total where you want them */;
   format var $var2tot.;
   by var notsorted;
   class var1;
   output out=want(drop=_:) sum(grp:)=;
run;



