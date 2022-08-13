function err=one6_Aim_between_pin_and_rigid(x)
format short
%x=x(1,1);
% bvib manual
% Tutorial: static analysis
% Units: m, kN
% Nodes=[NodID X Y Z]
% lspan = 75;   
%k1= 1.3e10;
%k2= 1.3e10;    
%k3= 1.3e7;
%k4= 1.3e7;
%k5= 1.5e10;
%k6= 1.5e10;   
% dy = 0.0001; %m, distance between nodes at a truss joint
yt=0;
yb=0;
b=0;
Nodes= [1000,0.00,0.00,0.00;
1002,9.30,0.00,0.00
1004,18.70,0.00,0.00
1006,28.10,0.00,0.00
1008,37.50,0.00,0.00
1010,46.90,0.00,0.00
1012,56.30,0.00,0.00
1014,65.70,0.00,0.00
1016,75.00,0.00,0.00 
2002,9.30,0.00,5.65
2004,18.70,0.00,9.73
2006,28.10,0.00,12.18
2008,37.50,0.00,13.00
2010,46.90,0.00,12.18
2012,56.30,0.00,9.73
2014,65.70,0.00,5.65
3000,0.00,5.00,0.00
3002,9.30,5.00,0.00
3004,18.70,5.00,0.00
3006,28.10,5.00,0.00
3008,37.50,5.00,0.00
3010,46.90,5.00,0.00
3012,56.30,5.00,0.00
3014,65.70,5.00,0.00
3016,75.00,5.00,0.00
4002,9.30,5.00,5.65
4004,18.70,5.00,9.73
4006,28.10,5.00,12.18
4008,37.50,5.00,13.00
4010,46.90,5.00,12.18
4012,56.30,5.00,9.73
4014,65.70,5.00,5.65                                                       
2001,7.3,0,4.45
2003,11.3,0,6.52
2005,23.4,0,10.958
2007,32.8,0,12.592
2009,42.2,0,12.592
2011,51.6,0,10.958
2015,67.7,0,4.45
2013,63.7,0,6.52 
4001,7.3,5,4.45
4003,11.3,5,6.52   
4005,23.4,5,10.958
4007,32.8,5,12.592
4009,42.2,5,12.592
4011,51.6,5,10.958
4015,75-7.3,5,4.45
4013,75-11.3,5,6.52 
2504,18.7,2.5,9.733 
2506,28.1,2.5,12.183 
2508,37.5,2.5,13      
2510,46.9,2.5,12.183;    
2512,56.3,2.5,9.733  
2601,21.05,1.25,10.344
2602,21.05,3.75,10.344   
2603,53.95,1.25,10.344
2604,53.95,3.75,10.344 
1500,0,1.965,0
1502,9.3,1.965,0
1504,18.7,1.965,0
1506,28.1,1.965,0
1508,37.5,1.965,0
1510,46.9,1.965,0
1512,56.3,1.965,0
1514,65.7,1.965,0
1516,75,1.965,0
3500,0,3.035,0
3502,9.3,3.035,0
3504,18.7,3.035,0
3506,28.1,3.035,0
3508,37.5,3.035,0
3510,46.9,3.035,0
3512,56.3,3.035,0
3514,65.7,3.035,0
3516,75,3.035,0 
10000,0,0,-1
30000,0.00,5.00,-1
10160,75.00,0.00,-1
30160,75.00,5.00,-1
20000,-1,0,0
40000,-1,5,0
9999,37.5,2.5,10
9998,37.5,10,5];
%E=2e11;
% reference node
% Check the node coordinates as follows:
% figure
% plotnodes(Nodes);
% Element types -> {EltTypID EltName}
Types=  {1        'beam';
         2        'link'};
% type 1 
% /Upper chord:     
A_u1	=	0.056;			% m2 (upper chord)
Iy_u1	=	0.0031;	        % m4 (strong axis)
Iz_u1	=	0.00067;       	% m4 (weak axis)
% wy_u1	=	0.440;	        % 
% wz_u1	=	0.600;           %	
%SECTYPE,1,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
A_u1b	=	0.060;			% m2 (upper chord)
Iy_u1b	=	0.00393	;        % m4 (strong axis)
Iz_u1b	=	0.00073;       	% m4 (weak axis)
%SECTYPE,101,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY :     
A_u2	=	0.05434	;		% m2 (upper chord)
Iy_u2	=	0.00293	;        % m4 (strong axis)
Iz_u2	=	0.000646 ;      	% m4 (weak axis)
% wy_u2	=	0.440;	        % 
% wz_u2	=	0.600 ;          %	
%SECTYPE,2,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY   
A_u3	=	0.03376	;		% m2 (upper chord)
Iy_u3	=	0.0019	;        % m4 (strong axis)
Iz_u3	=	0.00043 ;      	% m4 (weak axis)
% wy_u3	=	0.440	;        % 
% wz_u3	=	0.600   ;        %	
%SECTYPE,3,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY    
A_l1	=	0.0198;		% m2 (lower chord)
Iy_l1	=	0.000627;       % m4 (strong axis)
Iz_l1	=	0.000207;      	% m4 (weak axis)
% wy_l1	=	0.520;      
% wz_l1	=	0.420;       	
%SECTYPE,4,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
A_v1	=	0.010;		% m2 (vertical)
Iy_v1	=	1.15E-04;       % m4 (strong axis, the same direction with global X)
Iz_v1	=	5.49E-05;    	% m4 (weak axis, the same direction with global Y)
% wy_v1	=	0.320;	        % 
% wz_v1	=	0.438;           %	
%SECTYPE,5,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
 A_v2	=	0.02312	;	    % m2 (vertical)
Iy_v2	=	0.00065*1.2;         % m4 (strong axis, the same direction with global X)
Iz_v2	=	0.00016;    	    % m4 (weak axis, the same direction with global Y)
% wy_v2	=	0.420;	        % 
% wz_v2	=	0.472 ;          %	
%SECTYPE,6,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY    
 A_v3	=	0.01416;		    % m2 (vertical)
Iy_v3	=	0.000278;        % m4 (strong axis, the same direction with global X)
Iz_v3	=	0.000124;    	% m4 (weak axis, the same direction with global Y)
% wy_v3	=	0.320;	        % 
% wz_v3	=	0.438;           %	
%SECTYPE,7,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
 A_d1	=	0.01416;		    % m2 (diagonal)
Iy_d1	=	0.000278;        % m4 (strong axis)
Iz_d1	=	0.000124;   	% m4 (weak axis, the same direction with global Y)
% wy_d1	=	0.320	;        % 
% wz_d1	=	0.438 ;          %	
%SECTYPE,8,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY    
 A_d2	=	0.0147;		    % m2 (diagonal)
Iy_d2	=	0.00034;         % m4 (strong axis)
Iz_d2	=	0.00012;    	    % m4 (weak axis, the same direction with global Y)
% wy_d2	=	0.350;	        % 
% wz_d2	=	0.438;           %	
%SECTYPE,9,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY    
 A_d3	=	0.0154;		    % m2 (diagonal)
Iy_d3	=	0.0004 ;         % m4 (strong axis)
Iz_d3	=	0.00012;    	    % m4 (weak axis, the same direction with global Y)
% wy_d3	=	0.380	;        % 
% wz_d3	=	0.438 ;          %	
%SECTYPE,10,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY  
 A_s1	=	0.02135	;	    % m2 (stringer)
Iy_s1	=	0.002  ;         % m4 (strong axis, global Y driection)
Iz_s1	=	0.00016 ;   	    % m4 (weak axis, the same direction with global Y)
% wy_s1	=	0.250;	        % 
% wz_s1	=	0.700 ;          % (re-check%)	
%SECTYPE,11,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY   
 A_c1	=	0.026044;		% m2 (cross beam)
Iy_c1	=	3.20E-03  ;       % m4 (strong axis, global X driection)
Iz_c1	=	9.25E-05;    	% m4 (weak axis, the same direction with global Z)
% wy_c1	=	0.300	;        % 
% wz_c1	=	0.900 ;          % (re-check%)	
%SECTYPE,12,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY  
 A_c2	=	0.025544;		% m2 (cross beam)
Iy_c2	=	0.00361 ;        % m4 (strong axis, global X driection)
Iz_c2	=	0.000203 ;   	% m4 (weak axis, the same direction with global Z)
% wy_c2	=	0.400;	        % 
% wz_c2	=	0.900 ;          % (re-check%)	
%SECTYPE,13,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY 
 A_t1	=	0.053 ;		    % m2 (cross beam)
Iy_t1	=	0.0028 ;         % m4 (strong axis, global X driection)
Iz_t1	=	0.000625;    	% m4 (weak axis, the same direction with global Z)
% wy_t1	=	0.300;	        % 
% wz_t1	=	0.300 ;          % (re-check%)	
%SECTYPE,14,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY   
 A_t2	=	0.01464	;	    % m2 (cross beam)
Iy_t2	=	0.00086  ;        % m4 (strong axis, global X driection)
Iz_t2	=	0.000092 ;   	% m4 (weak axis, the same direction with global Z)
% wy_t2	=	0.300	 ;       % 
% wz_t2	=	0.300 ;          % (re-check%)	
%SECTYPE,15,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY     
 A_t3	=	0.0358	;	    % m2 (cross beam)
Iy_t3	=	0.00212;          % m4 (strong axis, global X driection)
Iz_t3	=	0.000513 ;   	% m4 (weak axis, the same direction with global Z)
% wy_t3	=	0.300;	        % 
% wz_t3	=	0.300;           % (re-check%)	
%SECTYPE,16,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY    
 A_t4	=	0.03376	;	    % m2 (cross beam)
Iy_t4	=	0.0019 ;         % m4 (strong axis, global X driection)
Iz_t4	=	0.00043;    	    % m4 (weak axis, the same direction with global Z)
% wy_t4	=	0.300;	        % 
% wz_t4	=	0.300 ;          % (re-check%)	
%SECTYPE,17,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKE  
 A_lb1	=	0.0049;		% m2 (cross beam)
Iy_lb1 = 4.38E-06;
Iz_lb1 = 2.38E-05;
%SECTYPE,18,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY   
 A_ub1	=	0.0036;		% m2 (cross beam)
Iy_ub1 = 1.09E-05;
Iz_ub1 = 8.00E-06;
%SECTYPE,19,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
 A_ub2	=	0.0019;	% m2 (cross beam)
Iy_ub2 = 1.40E-06;
Iz_ub2 = 1.90E-06;
%SECTYPE,20,BEAM, ASEC, , 0   %SECTYPE, SECID, Type, Subtype, Name, REFINEKEY
% Sections=[SecID A ky kz Ixx Iyy Izz yt yb zt zb]
Sections=[1 A_u1 Inf Inf 0 Iz_u1 Iy_u1 yt yb b/2 b/2;
            2 A_u2 Inf Inf 0 Iz_u2 Iy_u2 yt yb b/2 b/2;
            3 A_u3 Inf Inf 0 Iz_u3 Iy_u3 yt yb b/2 b/2;
            4 A_l1 Inf Inf 0 Iz_l1 Iy_l1 yt yb b/2 b/2;
            5 A_v1 Inf Inf 0 Iz_v1 Iy_v1 yt yb b/2 b/2;
            6 A_v2 Inf Inf 0 Iz_v2 Iy_v2 yt yb b/2 b/2;
            7 A_v3 Inf Inf 0 Iz_v3 Iy_v3 yt yb b/2 b/2;
            8 A_d1 Inf Inf 0 Iz_d1 Iy_d1 yt yb b/2 b/2;
            9 A_d2 Inf Inf 0 Iz_d2 Iy_d2 yt yb b/2 b/2;
           10 A_d3 Inf Inf 0 Iz_d3 Iy_d3 yt yb b/2 b/2;
           11 A_s1 Inf Inf 0 Iz_s1 Iy_s1 yt yb b/2 b/2;
           12 A_c1 Inf Inf 0 Iz_c1 Iy_c1 yt yb b/2 b/2;
           13 A_c2 Inf Inf 0 Iz_c2 Iy_c2 yt yb b/2 b/2;
           14 A_t1 Inf Inf 0 Iz_t1 Iy_t1 yt yb b/2 b/2;
           15 A_t2 Inf Inf 0 Iz_t2 Iy_t2 yt yb b/2 b/2;
           16 A_t3 Inf Inf 0 Iz_t3 Iy_t3 yt yb b/2 b/2;
           17 A_t4 Inf Inf 0 Iz_t4 Iy_t4 yt yb b/2 b/2;
           18 A_lb1 Inf Inf 0 Iz_lb1 Iy_lb1 yt yb b/2 b/2;
           19 A_ub1 Inf Inf 0 Iz_ub1 Iy_ub1 yt yb b/2 b/2;
           20 A_ub2 Inf Inf 0 Iz_ub2 Iy_ub2 yt yb b/2 b/2;
           21 A_u1b Inf Inf 0 Iz_u1b Iy_u1b yt yb b/2 b/2;
           22  Inf  Inf Inf Inf Inf Inf Inf Inf Inf Inf];            
% 2 pi*r^2 NaN NaN NaN NaN NaN NaN NaN NaN NaN];
% Materials=[MatID E nu]; E: N/m2
Materials= [1 x(1,1) 0.3 7850 Inf  
            2 1 1 1 x(1,2)       
            3 1 1 1 x(1,3) 
            4 1 1 1 x(1,4) 
            5 1 1 1 x(1,5) 
            6 1 1 1 x(1,6) 
            7 1 1 1 x(1,7)]; % steel
% 2 210e6 0.3]; % other
% Elements=[EltID TypID SecID MatID n1 n2 n3]
Elements= [1000  1  4 1  1000  1002  9999
    1003    1    4  1 1002  1004  9999
    1006    1    4  1 1004  1006  9999
    1009    1    4  1 1006  1008  9999
    1012    1    4  1 1008  1010  9999
    1015    1    4  1 1010  1012  9999
    1018    1    4  1 1012  1014  9999
    1021    1    4  1 1014  1016  9999
    1502    1    5  1 1002  2002  9998
    1504    1    6  1 1004  2004  9998
    1506    1    7  1 1006  2006  9998
    1508    1    5  1 1008  2008  9998
    1510    1    7  1 1010  2010  9998
    1512    1    6  1 1012  2012  9998
    1514    1    5  1 1014  2014  9998
    2000    1    1  1 1000  2001  9999
    2001    1   21  1 2001  2002  9999
    2002    1   21  1 2002  2003  9999
    2003    1   2   1 2003  2004  9999
    2004    1   3   1 2004  2005  9999
    2005    1   3   1 2005  2006  9999
    2006    1   3   1 2006  2007  9999
    2007    1   3  1  2007  2008  9999
    2008    1   3  1 2008  2009  9999
    2009    1   3  1 2009  2010  9999
    2010    1   3  1 2010  2011  9999
    2011    1   3  1 2011  2012  9999
    2012    1   2  1 2012  2013  9999
    2013    1   21 1 2013  2014  9999
    2014    1   21  1 2014  2015  9999
    2015    1   1  1 2015  1016  9999
    2502    1   8  1 1004  2002  9998
    2504    1   9  1 1006  2004  9998
    2506    1   10 1  1008  2006  9998
    2508    1   10 1  1008  2010  9998
    2510    1   9  1 1010  2012  9998
    2512    1   8  1 1012  2014  9998
    3000    1   4  1 3000  3002  9999
    3003    1   4  1 3002  3004  9999
    3006    1   4  1 3004  3006  9999
    3009    1   4  1 3006  3008  9999
    3012    1   4  1 3008  3010  9999
    3015    1   4  1 3010  3012  9999
    3018    1   4  1 3012  3014  9999
    3021    1   4  1 3014  3016  9999
    3502    1   5  1 3002  4002  9998
    3504    1   6  1 3004  4004  9998
    3506    1   7  1 3006  4006  9998
    3508    1   5  1 3008  4008  9998
    3510    1   7  1 3010  4010  9998
    3512    1   6  1 3012  4012  9998
    3514    1   5  1 3014  4014  9998
    4000    1   1  1 3000  4001  9999
    4001    1   21 1  4001  4002  9999
    4002    1   21 1  4002  4003  9999
    4003    1   2  1 4003  4004  9999
    4004    1   3  1 4004  4005  9999
    4005    1   3  1 4005  4006  9999
    4006    1   3  1 4006  4007  9999
    4007    1   3  1 4007  4008  9999
    4008    1   3  1 4008  4009  9999
    4009    1   3  1 4009  4010  9999
    4010    1   3  1 4010  4011  9999
    4011    1   3  1 4011  4012  9999
    4012    1   2  1 4012  4013  9999
    4013    1   21 1 4013  4014  9999
    4014    1   21 1  4014  4015  9999
    4015    1   1  1 4015  3016  9999
    4502    1   8  1 3004  4002  9998
    4504    1   9  1 3006  4004  9998
    4506    1   10  1 3008  4006  9998
    4508    1   10  1 3008  4010  9998
    4510    1   9  1 3010  4012  9998
    4512    1   8  1 3012  4014  9998
    5000    1   12  1 1000  1500  9999
    5002    1   13  1 1002  1502  9999
    5004    1   13  1 1004  1504  9999
    5006    1   13  1 1006  1506  9999
    5008    1   13  1 1008  1508  9999
    5010    1   13  1 1010  1510  9999
    5012    1   13  1 1012  1512  9999
    5014    1   13  1 1014  1514  9999
    5016    1   12  1 1016  1516  9999
    5100    1   12  1 1500  3500  9999
    5102    1   13  1 1502  3502  9999
    5104    1   13  1 1504  3504  9999
    5106    1   13  1 1506  3506  9999
    5108    1   13  1 1508  3508  9999
    5110    1   13  1 1510  3510  9999
    5112    1   13  1 1512  3512  9999
    5114    1   13  1 1514  3514  9999
    5116    1   12  1 1516  3516  9999
    5200    1   12  1 3500  3000  9999
    5202    1   13  1 3502  3002  9999
    5204    1   13  1 3504  3004  9999
    5206    1   13  1 3506  3006  9999
    5208    1   13  1 3508  3008  9999
    5210    1   13  1 3510  3010  9999
    5212    1   13  1 3512  3012  9999
    5214    1   13  1 3514  3014  9999
    5216    1   12  1 3516  3016  9999
    6000    1   11  1 1500  1502  9999
    6002    1   11  1 1502  1504  9999
    6004    1   11  1 1504  1506  9999
    6006    1   11  1 1506  1508  9999
    6008    1   11  1 1508  1510  9999
    6010    1   11  1 1510  1512  9999
    6012    1   11  1 1512  1514  9999
    6014    1   11  1 1514  1516  9999
    6100    1   11  1 3500  3502  9999
    6102    1   11  1 3502  3504  9999
    6104    1   11  1 3504  3506  9999
    6106    1   11 1  3506  3508  9999
    6108    1   11  1 3508  3510  9999
    6110    1   11  1 3510  3512  9999
    6112    1   11  1 3512  3514  9999
    6114    1   11  1 3514  3516  9999
    6200    1   18  1 1000  3002  9999
    6201    1   18  1 3000  1002  9999
    6202    1   18  1 1002  3004  9999
    6203    1   18  1 3002  1004  9999
    6204    1   18  1 1004  3006  9999
    6205    1   18  1 3004  1006  9999
    6206    1   18  1 1006  3008  9999
    6207    1   18  1 3006  1008  9999
    6208    1   18 1  1008  3010  9999
    6209    1   18 1  3008  1010  9999
    6210    1   18  1 1010  3012  9999
    6211    1   18  1 3010  1012  9999
    6212    1   18  1 1012  3014  9999
    6213    1   18  1 3012  1014  9999
    6214    1   18  1 1014  3016  9999
    6215    1   18  1 3014  1016  9999
    7004    1   14  1 2004  2504  9999
    7006    1   15  1 2006  2506  9999
    7008    1   16  1 2008  2508  9999
    7010    1   15  1 2010  2510  9999
    7012    1   14  1 2012  2512  9999
    7104    1   14  1 2504  4004  9999
    7106    1   15  1 2506  4006  9999
    7108    1   16  1 2508  4008  9999
    7110    1   15  1 2510  4010  9999
    7112    1   14  1 2512  4012  9999
    7204    1   19  1 2601  2005  9999
    7205    1   19  1 2005  2506  9999
    7206    1   19  1 2007  2506  9999
    7207    1   19  1 2007  2508  9999
    7208    1   19  1 2009  2508  9999
    7209    1   19  1 2009  2510  9999
    7210    1   19 1  2011  2510  9999
    7211    1   19 1  2011  2603  9999
    7304    1   19 1  2602  4005  9999
    7305    1   19  1 4005  2506  9999
    7306    1   19  1 4007  2506  9999
    7307    1   19  1 4007  2508  9999
    7308    1   19  1 4009  2508  9999
    7309    1   19  1 4009  2510  9999
    7310    1   19  1 4011  2510  9999
    7311    1   19  1 2604  4011  9999
    7401    1   20  1 2004  2601  9999
    7402    1   19  1 2504  2601  9999
    7403    1   19  1 2504  2602  9999
    7404    1   20  1 2602  4004  9999
    7405    1   20  1 2601  2602  9999
    7411    1   20  1 2012  2603  9999
    7412    1   19  1 2603  2512  9999
    7413    1   19  1 2512  2604  9999
    7414    1   20  1 2604  4012  9999
    7415    1   20  1 2603  2604  9999
    10000   2   22  2 1000  10000  NaN
    30000   2   22  3 3000  30000  NaN
    10160   2   22  4 1016  10160  NaN
    30160   2   22  5 3016  30160  NaN
    20000   2   22  6 1000  20000  NaN
    40000   2   22  7 3000  40000  NaN];
% Check node and element definitions as follows:
% hold('on');
% plotelem(Nodes,Elements,Types);
% title('Nodes and elements');
% Degrees of freedom
% Assemble a column matrix containing all DOFs at which stiffness is
% present in the model:
DOF=getdof(Elements,Types);
%DOF=dof_truss(NodeNum);
% Remove all DOFs equal to zero from the vector:
% - 3D analysis: 
% - Fixed at node 1
% - Roller at at node 11
%seldof=[0.04;0.05;1000.01;1000.02;1000.03;1016.02;1016.03;3000.01;3000.02;3016.02];%1016.03;%3000.03;%3016.03;%1000.03; ];
seldof=[10000.01;10000.02;10000.03;
    10000.04
    10000.05
    10000.06
    20000.01;
    20000.02;
    20000.03;
    20000.04
    20000.05
    20000.06
    40000.01;
    40000.02;
    40000.03;
    40000.04
    40000.05
    40000.06
    10160.01
    10160.02;
    10160.03;
    10160.04
    10160.05
    10160.06
     30000.01;
    30000.02;
    30000.03
    30000.04
    30000.05
    30000.06
    30160.01;
      30160.02;
      30160.03
      30160.04
      30160.05
      30160.06
      1000.01;
    1000.02;
    1000.03;
    1016.02;
    1016.03;
     3000.01;
    3000.02;
    3016.02;
    1002.04;
    1004.04;
    1006.04;
    1008.04;
    1010.04;
    1012.04;
    1014.04;
    2002.04;
    2004.04;
    2006.04;
    2008.04;
    2010.04;
    2012.04;
    2014.04;
    3002.04;
    3004.04;
    3006.04;
    3008.04;
3010.04;
3012.04;
3014.04;
4002.04;
4004.04;
4006.04;
4008.04;
4010.04;
4012.04;
4014.04;
2001.04;
2003.04;
2005.04;
2007.04;
2009.04;
2011.04;
2015.04;
2013.04;
4001.04;
4003.04;
4005.04;
4007.04;
4009.04;
4011.04;
4015.04;
4013.04;
2504.04;
2506.04;
2508.04;
2510.04;
2512.04;
2601.04;
2602.04;
2603.04;
2604.04;
1500.04;
1502.04;
1504.04;
1506.04;
1508.04;
1510.04;
1512.04;
1514.04;
1516.04;
3500.04;
3502.04;
3504.04;
3506.04;
3508.04;
3510.04;
3512.04;
3514.04;
3516.04
1002.05;
    1004.05;
    1006.05;
    1008.05;
    1010.05;
    1012.05;
    1014.05;
    2002.05;
    2004.05;
    2006.05;
    2008.05;
    2010.05;
    2012.05;
    2014.05;
    3002.05;
    3004.05;
    3006.05;
    3008.05;
3010.05;
3012.05;
3014.05;
4002.05;
4004.05;
4006.05;
4008.05;
4010.05;
4012.05;
4014.05;
2001.05;
2003.05;
2005.05;
2007.05;
2009.05;
2011.05;
2015.05;
2013.05;
4001.05;
4003.05;
4005.05;
4007.05;
4009.05;
4011.05;
4015.05;
4013.05;
2504.05;
2506.05;
2508.05;
2510.05;
2512.05;
2601.05;
2602.05;
2603.05;
2604.05;
1500.05;
1502.05;
1504.05;
1506.05;
1508.05;
1510.05;
1512.05;
1514.05;
1516.05;
3500.05;
3502.05;
3504.05;
3506.05;
3508.05;
3510.05;
3512.05;
3514.05;
3516.05];

DOF=removedof(DOF,seldof);
% Assembly of stiffness matrix K
[K,M]=asmkm(Nodes,Elements,Types,Sections,Materials,DOF);
% bvib manual
% Tutorial: dynamic analysis: eigenvalue problem
% Units: m, N
% Assembly of M and K
% Eigenvalue problem
nMode=20;
[phi,omega]=eigfem(K,M,nMode);
% Display eigenfrequenties
% disp('Lowest eigenfrequencies [Hz]');

%%
filename = 'After.mat';
Data = load(filename);
KK = Data.KK;
a=omega/2/pi;
idx=[1 2 3];
fre_FEM=a(idx)
nMode2=size(idx,2);
 [Phis,Lamdas]=eigfem(K,M,nMode2);
 nb_mode2=3; %is the row and column of bar3 command.
    MAC=zeros(nb_mode2,nb_mode2,nMode2); % Mean Mac(:,:,1) is a matrix zeros 6x6. to Mac(:,:,6); nmode_2 is the number of row and column; nMode2 is the number of page.
    for zz=1:nMode2
%  Vect_Num(:,:)=Phis(zz:nb_mode2:end,:);%zz:10:end means matrix phis has 300 row; if phis (zz:10:end), it will take row zz, row zz+10, row zz +30...
%  Vect_Exp(:,:)=KK(zz:nb_mode2:end,:);
    for ii=1:nMode2
        for jj=1:nMode2
           A=Phis(:,ii);
           B=KK(:,jj);
%             MAC(ii,jj,zz)= (abs(dot(A',B))^2)/(dot(A',A)*dot(B',B));
            %(abs(A'*B))^2/((A'*A)*(B'*B));
%            ; %A' is tranposed matrix
fre_Measured=[1.45;
    3.11
    3.28];
    %4.62];
    %6.05];
err=norm(fre_FEM-fre_Measured)+1-(abs(dot(A',B))^2)/(dot(A',A)*dot(B',B));
        end
    end
end
%%
% fre_Measured=[1.45;
%     3.11
%     3.28];
%     %4.62];
%     %6.05];
% err=norm(fre_FEM-fre_Measured)+1-(abs(dot(A',B))^2)/(dot(A',A)*dot(B',B));
end