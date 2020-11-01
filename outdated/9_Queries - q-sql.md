
# 9. Queries - q-sql

### 9.1.2. Bulk columnar insert


```q
\l data/sp.q
```


```q
aaa:3?`3
```


```q
aaa
```


```q
mytb:([id:100+til 10] name:10?`5;iq:10?80+til 40)
```


```q
mytb
```


```q
select[(2;0W)] from mytb
```

### 9.3.3. Filtering with where


```q
select from mytb where[like[name;"*oo*"]] / in SQL: where name like '*dd*'
```

- i is like serial in SQL. you can use it to select a range of records from a table based on their index


```q
select from mytb where i within 3 5 / selecting a range based on implicit index of table
```

#### 9.3.3.3. multiple where subhrases

- subphrases are sequenced from left-to-right, their order affects the actual processing.
- the net effect is a progressively narrowed sublist of rows to consider.
- Consequently, there is often an optimal order that significantly narrows in the first one or few subphrases -> reduces the amount of processing.
    - Place the most limiting where subphrase first, followed by others in decreasing strictness


```q
select from mytb where[like[name;"*j*"]&iq>100]
```


```q
select from mytb where[like[name;"*j*"]|iq>100]
```

#### __Nested columns in where__

- Use one of the maps iterators: each('), each left(\:), each right (/:), each parallel, each prior (':), case ('                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  )
    - cross: each left and each right combined \:/:


```q
t:([] f:1.1 2.2 3.3; s:("abc";enlist "d";"ef"))
```


```q
select from t where s="ef" / will fail
```


```q
select from t where s~"ef"
```


```q
select from t where s~\:"ef"
```


```q
select from t where "ef"~/:s
```


```q
1 2 3 in'(1 0 1;til 100;5 6 7)
```

#### __9.3.3.5. fby in where__

- fby is the equivalent of HAVING in SQL
- fby returns the vaue of the aggregate across each group

- syntax: (f_agg;expr_col) fby colname
    - f_agg: aggregate function
    - expr_col: column expression on which f_agg is applied
    - colname: is the column to be grouped

- __what fby does__: Since it returns the value of the aggregate across each group, you simply compare the target column to the fby result to get a boolean vector with 1b at precisely the records whose fields match the aggregate on the group.


```q
p
```


```q
select from p where weight=max weight
```


```q
select max weight by city from p
```


```q
select name, color, max weight by city from p
```


```q
select first name, first color, max weight by city from p
```


```q
select from p where weight=(max;weight) fby city
```


```q
select from p where weight=fby[(max;weight);city]
```

- The right solution with multiple where phrases:


```q
select from p where weight=fby[(max;weight);city],color=`blue
```

- __Grouping on multiple columns__
    - encapsulate multiple columns in an anonymous table


```q
select from p where weight=fby[(max;weight);([] city;color)]
```

### __9.3.4. Grouping and aggregation__

- grouping and aggregation is performed together in SQL
- grouping and aggregation is performed independently in q-sql

#### 9.3.4.1. Aggregation without grouping

- aggregation by one column -> result atom
- aggregation by multiple columns -> result a table with a single record


```q
sp
```


```q
select sum qty from sp
```


```q
select total:sum qty, mean:avg qty from sp
```

#### 9.3.4.2. Grouping without aggregation

- similar to GROUP BY in SQL
- the _by_ phrase groups rows having common values in specified columns
- the result of a by phrase query is a __keyed table__ whise key columns are in the by phrase
- the by phrase is a generalization of the _group_ function on lists
- result: nested columns
- not advised to do this. nested columns are:
    - slower
    - more cumbersome to work with (need adverbs)
    - unnecessary
- _ungroup_ reverses the nested result of grouping without aggregation (cannot be used on lists groupped with _group_)


```q
s
```


```q
select by s from sp / by not specifying any non-group by columns, the last elements of these columns are selected
```


```q
spGrouped:select p,qty by s from sp
```


```q
select p,qty by s from sp
```


```q
`s xgroup sp / is the same as the above select phrase except it is not ordered by the group by columns
```


```q
select p,total:sum qty by s from sp
```


```q
ungroup spGrouped
```


```q
groupped:group 1 3 2 5 7 1 3 5 7 2 1
```

#### 9.3.4.3. Grouping with aggregation

- usual usage of _by_
- use case: aggregate col1 by col2 in _the by_ phrase
- result: a keyed table whose keys are the values of the grouped _by_ column
- grouping on multiple columns -> a table with composite keys


```q
select total:sum qty by s from sp
```


```q
select total:sum qty by s,p from sp
```

- you can group on computed columns (a _by_ subphrase can contain a q expression)
    - and use the computed column as a new column in the query
- a frequent expression is xbar which can be used to create intervals from a list containing numeric atoms


```q
trade:([] c1:00:00:00.000+til 1000000;c2:1000000?`a`b;c3:1000000?100.)
```


```q
trade
```


```q
select avg c3 by 100 xbar c1 from trade
```

## 9.4. __The _exec_ template__

- the syntax of the exed template is identical to that of select:
    - exec <p_s> by <p_b> from t_exp where <p_w>
- the selut type of exec depends on the number of columns in its select phrase
    - one columns yields a list
    - two or more columns yields a dictionary
- the resulting columns lists do not have to be rectangular!!!


```q

```


```q

```


```q

```


```q

```


```q

```


```q

```


```q

```


```q

```


```q

```
