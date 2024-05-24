B = zeros(4,1) ;

for i = 1:1:4

 [xt,yt] = VecTr(A(i,1),A(i,2),2,2,pi/4) ;

B(i,1) = xt ;
B(i,2) = yt ;

end


line(A([1,2],1),A([1,2],2))
hold on
line(A([2,3],1),A([2,3],2))
hold on
line(A([3,4],1),A([3,4],2))
hold on
line(A([4,1],1),A([4,1],2))

hold on

line(B([1,2],1),B([1,2],2))
hold on
line(B([2,3],1),B([2,3],2))
hold on
line(B([3,4],1),B([3,4],2))
hold on
line(B([4,1],1),B([4,1],2))

axis equal





