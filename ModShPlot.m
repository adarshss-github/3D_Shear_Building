
for i = 1:1:18

    PlotMultStorUnSymMod(Phi(:,i),nf,sc)
     cd("C:\Users\CHIKKU-ADI\Desktop\3D_Building\ModeShapesUnSym")
      saveas(gcf,['Mode' num2str(i) '.png'])
       saveas(gcf,['Mode' num2str(i) '.fig'])

 cd("C:\Users\CHIKKU-ADI\Desktop\3D_Building")
 close all


end

for i = 1:1:18

    PlotMultStorUnSymMod(Phi(:,i),nf,sc)
     cd("C:\Users\CHIKKU-ADI\Desktop\3D_Building\ModesShapesSym")
      saveas(gcf,['Mode' num2str(i) '.png'])
       saveas(gcf,['Mode' num2str(i) '.fig'])

 cd("C:\Users\CHIKKU-ADI\Desktop\3D_Building")
 close all


end