
\l data/sp.q

aaa:3?`3

aaa

mytb:([id:100+til 10] name:10?`5;iq:10?80+til 40)

mytb

select[(2;0W)] from mytb

select from mytb where[like[name;"*oo*"]] / in SQL: where name like '*dd*'

select from mytb where i within 3 5 / selecting a range based on implicit index of table

select from mytb where[like[name;"*j*"]&iq>100]

select from mytb where[like[name;"*j*"]|iq>100]

t:([] f:1.1 2.2 3.3; s:("abc";enlist "d";"ef"))

select from t where s="ef" / will fail

select from t where s~"ef"

select from t where s~\:"ef"

select from t where "ef"~/:s

1 2 3 in'(1 0 1;til 100;5 6 7)

p

select from p where weight=max weight

select max weight by city from p

select name, color, max weight by city from p

select first name, first color, max weight by city from p

select from p where weight=(max;weight) fby city

select from p where weight=fby[(max;weight);city]

select from p where weight=fby[(max;weight);city],color=`blue

select from p where weight=fby[(max;weight);([] city;color)]

sp

select sum qty from sp

select total:sum qty, mean:avg qty from sp

s

select by s from sp / by not specifying any non-group by columns, the last elements of these columns are selected

spGrouped:select p,qty by s from sp

select p,qty by s from sp

`s xgroup sp / is the same as the above select phrase except it is not ordered by the group by columns

select p,total:sum qty by s from sp

ungroup spGrouped

groupped:group 1 3 2 5 7 1 3 5 7 2 1

select total:sum qty by s from sp

select total:sum qty by s,p from sp

trade:([] c1:00:00:00.000+til 1000000;c2:1000000?`a`b;c3:1000000?100.)

trade

select avg c3 by 100 xbar c1 from trade


















