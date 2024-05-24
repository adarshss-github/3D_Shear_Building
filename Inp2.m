for  i = 1:1:nf+1

scatter3(FCor(:,1,i),FCor(:,2,i),FCor(:,3,i),70,'filled','MarkerEdgeColor','k',...
        'MarkerFaceColor',[0.6350 0.0780 0.1840])


hold on



end


axis equal

for  i = 1:1:nf+1


plot3(FCor([1,2],1,i),FCor([1,2],2,i),FCor([1,2],3,i))
hold on
plot3(FCor([2,3],1,i),FCor([2,3],2,i),FCor([2,3],3,i))
hold on
plot3(FCor([3,4],1,i),FCor([3,4],2,i),FCor([3,4],3,i))
hold on
plot3(FCor([4,1],1,i),FCor([4,1],2,i),FCor([4,1],3,i))

hold on



end




axis equal

for  i = 1:1:nf+1


plot3(FCorT([1,2],1,i),FCorT([1,2],2,i),FCorT([1,2],3,i))
hold on
plot3(FCorT([2,3],1,i),FCorT([2,3],2,i),FCorT([2,3],3,i))
hold on
plot3(FCorT([3,4],1,i),FCorT([3,4],2,i),FCorT([3,4],3,i))
hold on
plot3(FCorT([4,1],1,i),FCorT([4,1],2,i),FCorT([4,1],3,i))

hold on



end




axis equal