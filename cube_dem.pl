:- use_module('METAGOL/metagol').

%% metagol settings
body_pred(poly/1).
body_pred(joins/2).
body_pred(sides/2).
body_pred(allSides/2).
body_pred(angle_between/3).
body_pred(angle_between_aux/3).
body_pred(angle/2).
body_pred(same_angle/2).


%% Examples
poly(c_1).                poly(c_4).                   
poly(c_2).                poly(c_5).               
poly(c_3).                

poly(p_1).                poly(t_1). 
poly(p_2).                poly(t_2).
poly(p_3).                poly(t_3).
poly(p_4).

poly(c_7).                poly(z_1).                                
poly(c_8).                poly(z_2).               
poly(c_9).  

joins(c_1,c_2).           joins(c_4,c_5).       
joins(c_1,c_3).           joins(c_5,c_4).      
joins(c_2,c_3).              
joins(c_2,c_1).                  
joins(c_2,c_1).                   
joins(c_3,c_2).            

joins(p_1,p_2).           joins(t_1,t_2).
joins(p_1,p_3).           joins(t_1,t_3).
joins(p_1,p_4).           joins(t_2,t_3).
joins(p_2,p_3).           joins(t_2,t_1).
joins(p_3,p_4).           joins(t_2,t_1).
joins(p_2,p_1).           joins(t_3,t_2).
joins(p_3,p_1).           
joins(p_4,p_1).
joins(p_3,p_2).            
joins(p_4,p_3).

joins(c_7,c_8).           joins(z_1,z_2).        
joins(c_7,c_9).           joins(z_2,z_1).
joins(c_8,c_9).          
joins(c_8,c_7).           
joins(c_9,c_7).                
joins(c_9,c_8).           

angle_between(c_1,c_2, 90).    angle_between(c_4,c_5, 90).   
angle_between(c_1,c_3, 90).    angle_between(c_5,c_4, 90).   
angle_between(c_2,c_3, 90).    
angle_between(c_2,c_1, 90).     
angle_between(c_3,c_1, 90).        
angle_between(c_3,c_2, 90).    

angle_between(p_1,p_2, 90).    angle_between(t_1,t_2, 90).        
angle_between(p_1,p_3, 90).    angle_between(t_1,t_3, 90).          
angle_between(p_1,p_4, 90).    angle_between(t_2,t_3, 60).
angle_between(p_2,p_1, 90).    angle_between(t_2,t_1, 90).       
angle_between(p_3,p_1, 90).    angle_between(t_3,t_1, 90).          
angle_between(p_4,p_1, 90).    angle_between(t_3,t_2, 60).
angle_between(p_2,p_3, 120).
angle_between(p_3,p_4, 120).
angle_between(p_3,p_2, 120).
angle_between(p_4,p_3, 120).

angle_between(c_7,c_8, 90).    angle_between(z_1,z_2, 120).
angle_between(c_7,c_9, 90).    angle_between(z_2,z_1, 120).
angle_between(c_8,c_9, 120).    
angle_between(c_8,c_7, 90).    
angle_between(c_9,c_7, 90).    
angle_between(c_9,c_8, 120).    


sides(c_1, 4).      sides(c_4, 4).     
sides(c_2, 4).      sides(c_5, 4).       
sides(c_3, 4).      
           
sides(p_1, 6).      sides(t_1, 3). 
sides(p_2, 4).      sides(t_2, 4).
sides(p_3, 4).      sides(t_3, 4).
sides(p_4, 4).

sides(c_7, 4).      sides(z_1, 3).    
sides(c_8, 4).      sides(z_2, 3).
sides(c_9, 4).


% Background Knowledge
same_angle([Head|[]], Deg).
same_angle([Head|Tail], Deg):-
  compare_angles(Head,Tail,Deg),
  same_angle(Tail, Deg).

compare_angles(H, [], Deg).
compare_angles(H, [S|T], Deg):-
  angle_between(H, S, Deg),
  compare_angles(S,T,Deg).

%% True if all faces of a shape have the same number of edges.
allSides([], Num).
allSides([H|T], Num):-
  sides(H, Num),
  allSides(T, Num).



%% metarules
metarule([P,C1], [P,A,C1], []).
metarule([P,Q,C1], [P,A], [[Q,A,C1]]).
metarule([P,Q,R,C1], [P,A], [[Q,A],[R,A,C1]]).
metarule([P,Q,R,C1,C2], [P,A], [[Q,A,C2],[R,A,C1]]).


%% learning task
:-
  %% positive examples
  Pos = [
    cube([c_1,c_2,c_3]),
    cube([c_2,c_1,c_3]), 
    cube([c_3,c_2,c_1]),
    cube([c_5,c_4]),
    cube([c_4,c_5])
  ],
  %% negative examples
  Neg = [
    cube([p_1,p_2,p_3,p_4]),
    cube([p_2,p_1,p_4,p_3]),
    cube([t_1,t_2,t_3]),
    cube([t_2,t_1,t_3]),
    cube([c_7,c_8,c_9]),
    cube([c_9,c_8,c_7]),
    cube([z_1,z_2]),
    cube([z_2,z_1])
  ],
  learn(Pos,Neg).
