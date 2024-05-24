function [] = PlotMultStorUnSymMod(Phi,nf,sc)

Phi = sc*Phi ;
MCor = zeros(1,3,nf+1) ;

j = nf:-1:1 ;

for i = 2:1:nf+1


MCor(1,1,i) = Phi(3*j(i-1)-2) ;
MCor(1,2,i) = Phi(3*j(i-1)-1) ;
MCor(1,3,i) = Phi(3*j(i-1)) ;


end

FCor = zeros(4,3,nf+1) ;
FCorT = zeros(4,3,nf+1) ;

FCor(1,:,1) = [1,1,0] ;
FCor(2,:,1) = [-1,1,0] ;
FCor(3,:,1) = [-1,-1,0] ;
FCor(4,:,1) = [1,-1,0] ;


for i = 2:1:nf+1

FCor(1,:,i) = [1,1,2*(i-1)] ;
FCor(2,:,i) = [-1,1,2*(i-1)] ;
FCor(3,:,i) = [-1,-1,2*(i-1)] ;
FCor(4,:,i) = [1,-1,2*(i-1)] ;

end

FCorT(:,:,1) = FCor(:,:,1) ;

for i = 2:1:nf+1

for j = 1:1:4
      
    V = FCor(j,:,i) ;
    [xt,yt] = VecTr(V(1),V(2),MCor(1,1,i),MCor(1,2,i),MCor(1,3,i)) ;
    FCorT(j,1,i) = xt ;
    FCorT(j,2,i) = yt ;
    FCorT(j,3,i) = V(3) ;

end

end

for  i = 1:1:nf+1

scatter3(FCorT(:,1,i),FCorT(:,2,i),FCorT(:,3,i),70,'filled','MarkerEdgeColor','k',...
        'MarkerFaceColor',[0.6350 0.0780 0.1840])


hold on



end




for  i = 2:1:nf+1




plot3(FCorT([1,2],1,i),FCorT([1,2],2,i),FCorT([1,2],3,i),'Color','k')
hold on
plot3(FCorT([2,3],1,i),FCorT([2,3],2,i),FCorT([2,3],3,i),'Color','k')
hold on
plot3(FCorT([3,4],1,i),FCorT([3,4],2,i),FCorT([3,4],3,i),'Color','k')
hold on
plot3(FCorT([4,1],1,i),FCorT([4,1],2,i),FCorT([4,1],3,i),'Color','k')
hold on



end

for  i = 1:1:nf




plot3([FCorT(1,1,i);FCorT(1,1,i+1)],[FCorT(1,2,i);FCorT(1,2,i+1)],[FCorT(1,3,i);FCorT(1,3,i+1)],'Color','k')
hold on
plot3([FCorT(2,1,i);FCorT(2,1,i+1)],[FCorT(2,2,i);FCorT(2,2,i+1)],[FCorT(2,3,i);FCorT(2,3,i+1)],'Color','k')
hold on
plot3([FCorT(3,1,i);FCorT(3,1,i+1)],[FCorT(3,2,i);FCorT(3,2,i+1)],[FCorT(3,3,i);FCorT(3,3,i+1)],'Color','k')
hold on
plot3([FCorT(4,1,i);FCorT(4,1,i+1)],[FCorT(4,2,i);FCorT(4,2,i+1)],[FCorT(4,3,i);FCorT(4,3,i+1)],'Color','k')
hold on



end



axis equal
grid off
axis off





end