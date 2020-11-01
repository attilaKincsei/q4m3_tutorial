
tournament1:("1:1";"2:2";"3:3";"4:4";"2:2";"3:3";"4:4";"3:3";"4:4";"4:4")
tournament2:("1:0";"2:0";"3:0";"4:0";"2:1";"3:1";"4:1";"3:2";"4:2";"4:3")
tournament3:("0:1";"0:2";"0:3";"0:4";"1:2";"1:3";"1:4";"2:3";"2:4";"3:4")
tournament4:("1:0";"2:0";"3:0";"4:0";"2:1";"1:3";"1:4";"2:3";"2:4";"3:4")
tournament5:("1:0";"2:0";"3:0";"4:4";"2:2";"3:3";"1:4";"2:3";"2:4";"3:4")

split:{[game] ":" vs game}

add_points:{[scores] $[scores[0]>scores[1];3;scores[0]=scores[1];1;0]}

points:{[games] score_matrix:"J"$split each games;points:0; points+:add_points each score_matrix;sum points}

test_points:{[games;expected] expected~points[games]}

test_points[("1:1";"2:2";"3:3";"4:4";"2:2";"3:3";"4:4";"3:3";"4:4";"4:4"); 10]
test_points[("1:0";"2:0";"3:0";"4:0";"2:1";"3:1";"4:1";"3:2";"4:2";"4:3"); 30]
test_points[("0:1";"0:2";"0:3";"0:4";"1:2";"1:3";"1:4";"2:3";"2:4";"3:4"); 0]
test_points[("1:0";"2:0";"3:0";"4:0";"2:1";"1:3";"1:4";"2:3";"2:4";"3:4"); 15]
test_points[("1:0";"2:0";"3:0";"4:4";"2:2";"3:3";"1:4";"2:3";"2:4";"3:4"); 12]

litres:{floor x%2}

hydreted_assert_equals:{[hours;expected] expected~litres[hours]}

hydreted_assert_equals[2;1]
hydreted_assert_equals[1.4; 0]
hydreted_assert_equals[12.3; 6]
hydreted_assert_equals[0.82; 0]
hydreted_assert_equals[11.8; 5]
hydreted_assert_equals[1787; 893]
hydreted_assert_equals[0; 0]

remove_element:{[input] @[input;1+2*til floor (count input)%2]}

remove_element[til 12]

remove_odds:{remove_element each x 1}

test_list:til 10
test_list

@[test_list;1+2*til floor (count test_list)%2]

pos_neg:{countp:count x[where x>0];sumn:sum x[where x<0];$[x~();();(countp;sumn)]}

pos_neg[(1;2;3;4;5;6;7;8;9;10;-11;-12;-13;-14;-15)] ~ (10;-65)
pos_neg[(0;2;3;0;5;6;7;8;9;10;-11;-12;-13;-14)]~(8;-50)
pos_neg[(enlist 1)]~(1;0)
pos_neg[(enlist -1)]~(0;-1)
pos_neg[(0;0;0;0;0;0;0;0;0)]~(0;0)
pos_neg[()]~()
