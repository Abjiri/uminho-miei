/* Objective function */

min:  600 r1_1 + 300 r1_2 + 1000 r2_1 + 500 r2_2 + 200 r3_1 + 100 r3_2 + 800 r4_1 + 400 r4_2 + 1600 r5_1 + 800 r5_2 +
200 r8_1 + 100 r8_2 + 1000 r10_1 + 500 r10_2 + 600 r11_1 + 300 r11_2;


/* Variable bounds */
tf <= 21;

arco_i1:   t1 >= ti + 0 ;
arco_12:   t2 >= t1 - r1_1 - r1_2 + 6 ;
arco_23:   t3 >= t2 - r2_1 - r2_2 + 7 ;
arco_3f:   tf >= t3 - r3_1 - r3_2 + 2 ;
arco_i4:   t4 >= ti + 0 ;
arco_42:   t2 >= t4 - r4_1 - r4_2 + 9 ;
arco_45:   t5 >= t4 - r4_1 - r4_2 + 9 ;
arco_53:   t3 >= t5 - r5_1 - r5_2 + 4 ;
arco_5f:   tf >= t5 - r5_1 - r5_2 + 4 ;
arco_i7:   t7 >= ti + 0 ;
arco_74:   t4 >= t7 - r7_1 - r7_2 + 6 ;
arco_78:   t8 >= t7 - r7_1 - r7_2 + 6 ;
arco_85:   t5 >= t8 - r8_1 - r8_2 + 4 ;
arco_89:   t9 >= t8 - r8_1 - r8_2 + 4 ;
arco_9f:   tf >= t9 - r9_1 - r9_2 + 2 ;
arco_i10:  t10 >= ti + 0;
arco_108:  t8 >= t10 - r10_1 - r10_2 + 8 ;
arco_1011: t11 >= t10 - r10_1 - r10_2 + 8;
arco_119:  t9 >= t11 - r11_1 - r11_2 + 7 ;

r1_1 <= 1;
r2_1 <= 3;
r3_1 <= 0.5;
r4_1 <= 2;
r5_1 <= 0.5;
r7_1 <= 0;
r8_1 <= 0.5;
r9_1 <= 0;
r10_1 <= 0.5;
r11_1 <= 1;

r1_1 + 100 y1 >= 1;
r1_1 + 100 y1 < 1 + 100;
r1_2 <= 1 - y1;

r2_1 + 100 y2 >= 3;
r2_1 + 100 y2 < 3 + 100;
r2_2 <= 1 - y2;

r3_1 + 100 y3 >= 0.5;
r3_1 + 100 y3 < 0.5 + 100;
r3_2 <= 0.5 - 0.5 y3;

r4_1 + 100 y4 >= 2;
r4_1 + 100 y4 < 2 + 100;
r4_2 <= 1 - y4;

r5_1 + 100 y5 >= 0.5;
r5_1 + 100 y5 < 0.5 + 100;
r5_2 <= 0.5 - 0.5 y5;

r7_1 + 100 y7 >= 0;
r7_1 + 100 y7 < 0 + 100;
r7_2 <= 0;

r8_1 + 100 y8 >= 0.5;
r8_1 + 100 y8 < 0.5 + 100;
r8_2 <= 0.5 - 0.5 y8;

r9_1 + 100 y9 >= 0;
r9_1 + 100 y9 < 0 + 100;
r9_2 <= 0 ;

r10_1 + 100 y10 >= 0.5;
r10_1 + 100 y10 < 0.5 + 100;
r10_2 <= 0.5 - 0.5 y10;

r11_1 + 100 y11 >= 1;
r11_1 + 100 y11 < 1 + 100;
r11_2 <= 1 - y11;

bin y1,y2,y3,y4,y5,y7,y8,y9,y10,y11;