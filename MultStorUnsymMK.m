function [M,K] = MultStorUnsymMK(a,b,m,kx1,kx2,ky1,ky2,nf)


%===========================================================================================================================================================
%***********************************************************************************************************************************************************
%
%                                      --------------------------------------------------
%                                                          PREAMBLE
%                                      --------------------------------------------------
%
% [M,K] = MultStorUnsymMK(a,b,m,kx1,kx2,ky1,ky2,nf)
%
%By Adarsh S, Ph.D. Candidate IIT Kanpur
%
%Description:
%------------
%This function returns global mass and stiffness matrices of a multistory
%unsymmetric building with rigid floor diaphragms
%
%Input arguments:
%----------------
%1) a: Vector containing geometric dimension 1 of each floor diaphragm (see picture)
%2) b: Vector containing geometric dimension 2 of each floor diaphragm (see picture)
%3) m: Vector containing mass of each floor diaphragm 
%4) kx1: Vector containing stiffness of frame x1 of each floor (see picture)
%5) kx2: Vector containing stiffness of frame x2 of each floor (see picture)
%6) ky1: Vector containing stiffness of frame y1 of each floor (see picture)
%7) ky2: Vector containing stiffness of frame y2 of each floor (see picture)
%8) nf: Total number of floors
%
%Output arguments:
%----------------
%1)M: Golbal mass matrix of building
%2)K: Global stiffness matrix of building
%
%Ex: [M,K] = MultStorUnsymMK(a,b,m,kx1,kx2,ky1,ky2,nf)
%
%                                      -----------------------------------------------
%                            *********|| All rights reserved; Adarsh S; October, 2019 || *********
%                                      -----------------------------------------------
%
%
%***********************************************************************************************************************************************************
%===========================================================================================================================================================

ndof = 3*nf ;

K = zeros(ndof,ndof) ;
M = zeros(ndof,ndof) ;
ke = zeros(9,9,nf) ;
Kge = zeros(ndof,ndof,nf) ;
dofe = zeros(9,nf) ;

% Formation of the mass matrix

for i = 1:1:nf

M(3*i-1,3*i-1) = m(i) ;
M(3*i-2,3*i-2) = m(i) ;
M(3*i,3*i) = (1/12)*m(i)*(a(i)^2 + b(i)^2) ;



end

dofe(1,1) = 3*1-2 ;
dofe(2,1) = 3*1-1 ;
dofe(3,1) = 3*1 ;
dofe(4,1) = 3*2-2 ;
dofe(5,1) = 3*2-1 ;
dofe(6,1) = 3*2 ;

dofe(4,nf) = 3*(nf-1)-2 ;
dofe(5,nf) = 3*(nf-1)-1 ;
dofe(6,nf) = 3*(nf-1) ;
dofe(7,nf) = 3*nf-2 ;
dofe(8,nf) = 3*nf-1 ;
dofe(9,nf) = 3*nf ;

for i = 2:1:nf-1

dofe(1,i) = 3*(i-1)-2 ;
dofe(2,i) = 3*(i-1)-1  ;
dofe(3,i) = 3*(i-1) ;
dofe(4,i) = 3*i-2 ;
dofe(5,i) = 3*i-1 ;
dofe(6,i) = 3*i ;
dofe(7,i) = 3*(i+1)-2 ;
dofe(8,i) = 3*(i+1)-1  ;
dofe(9,i) = 3*(i+1) ;




end

%========================================================================

%Stiffness matrix of top floor

%X
%---

ke(1,1,1) = kx1(1) + kx2(1) ;
ke(1,3,1) = a(1)*0.5*(kx2(1) - kx1(1)) ;
ke(1,4,1) = -( kx1(1) + kx2(1) ) ;
ke(1,6,1) = -( a(1)*0.5*(kx2(1) - kx1(1)) ) ;

% ke(3,1,1) = a(1)*0.5*(kx2(1) - kx1(1)) ;
% ke(4,1,1) = -( kx1(1) + kx2(1) ) ;
% ke(6,1,1) = -( a(1)*0.5*( kx2(1) - kx1(1)) ) ;

%Y
%---
ke(2,2,1) = ky1(1) + ky2(1) ;
ke(2,3,1) = b(1)*0.5*( ky2(1) - ky1(1) ) ;
ke(2,5,1) = -( ky1(1) + ky2(1) ) ;
ke(2,6,1) = -( b(1)*0.5*( ky2(1) - ky1(1)) ) ;

% ke(3,2,1) = b(1)*0.5*( ky2(1) - ky1(1) )  ;
% ke(5,2,1) = -( ky1(1) + ky2(1) ) ;
% ke(6,2,1) = -( b(1)*0.5*(ky2(1) - ky1(1)) ) ;

%Theta
%---
ke(3,1,1) = a(1)*0.5*(kx2(1) - kx1(1)) ;
ke(3,2,1) = b(1)*0.5*( ky2(1) - ky1(1) )  ;
ke(3,3,1) = a(1)^2*0.25*( kx1(1) + kx2(1) ) + b(1)^2*0.25*( ky1(1) + ky2(1) ) ;
ke(3,4,1) = -a(1)^2*0.5*( kx2(1) - kx1(1) ) ;
ke(3,5,1) = -( b(1)*0.5*( ky2(1) - ky1(1) ) ) ;
ke(3,6,1) = -a(1)^2*0.25*(kx1(1) + kx2(1)) -b(1)^2*0.25*(ky1(1) + ky2(1)) ;

% ke(4,3,1) = -a(1)^2*0.5*( kx2(1) - kx1(1) ) ;
% ke(5,3,1) = -( b(1)*0.5*( ky2(1) - ky1(1)) ) ;
% ke(6,3,1) = -a(1)^2*0.25*( kx1(1) + kx2(1) ) -b(1)^2*0.25*( ky1(1) + ky2(1))  ;


%=====================================================================

%=====================================================================

%Stiffness matrix of bottom floor

%X
%---
ke(7,4,nf) = -kx1(nf-1) - kx2(nf-1) ;
ke(7,6,nf) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
ke(7,7,nf) = kx1(nf) + kx2(nf) + kx1(nf-1) + kx2(nf-1) ;
ke(7,9,nf) = a(nf-1)*0.5*( kx2(nf-1)-kx1(nf-1) ) + a(nf)*0.5*( kx2(nf)-kx1(nf) ) ;

% ke(4,7,nf) = -kx1(nf-1) - kx2(nf-1) ;
% ke(6,7,nf) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
% ke(9,7,nf) = a(nf-1)*0.5*( kx2(nf-1)-kx1(nf-1) ) + a(nf)*0.5*( kx2(nf)-kx1(nf) ) ;

%Y
%---
ke(8,5,nf) = -ky1(nf-1) - ky2(nf-1) ;
ke(8,6,nf) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
ke(8,8,nf) = ky1(nf) + ky2(nf) + ky1(nf-1) + ky2(nf-1) ;
ke(8,9,nf) = b(nf-1)*0.5*( ky2(nf-1)-ky1(nf-1) ) + b(nf)*0.5*( ky2(nf)-ky1(nf) ) ;

% ke(5,8,nf) = -ky1(nf-1) - ky2(nf-1) ;
% ke(6,8,nf) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
% ke(9,8,nf) = b(nf-1)*0.5*( ky2(nf-1)-ky1(nf-1) ) + b(nf)*0.5*( ky2(nf)-ky1(nf) ) ;

%Theta
%-----
ke(9,4,nf) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
ke(9,5,nf) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
ke(9,6,nf) = -a(nf-1)^2*0.25*( kx1(nf-1) + kx2(nf-1) ) -b(nf-1)^2*0.25*( ky1(nf-1) + ky2(nf-1) ) ;
ke(9,7,nf) = a(nf-1)*0.5*( kx2(nf-1)-kx1(nf-1) ) + a(nf)*0.5*( kx2(nf)-kx1(nf) ) ;
ke(9,8,nf) = b(nf-1)*0.5*( ky2(nf-1)-ky1(nf-1) ) + b(nf)*0.5*( ky2(nf)-ky1(nf) ) ;
ke(9,9,nf) = a(nf-1)^2*0.25*( kx2(nf-1)+kx1(nf-1) ) +  a(nf)^2*0.25*( kx2(nf)+kx1(nf) ) + b(nf-1)^2*0.25*( ky2(nf-1)+ky1(nf-1) ) +  b(nf)^2*0.25* (ky2(nf)+ky1(nf) ) ;

% ke(4,9,nf) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
% ke(5,9,nf) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
% ke(6,9,nf) = -a(nf-1)^2*0.25*( kx1(nf-1) + kx2(nf-1) ) -b(nf-1)^2*0.25*( ky1(nf-1) + kx2(nf-1) ) ;



%=====================================================================


for i = 2:1:nf-1

 %X
 %--
ke(4,1,i) = -kx1(nf-1) - kx2(nf-1) ;
ke(4,3,i) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
ke(4,4,i) = kx1(nf-1) + kx2(nf-1) + kx1(nf) + kx2(nf) ; 
ke(4,6,i) = a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) + a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;
ke(4,7,i) =  -kx1(nf) - kx2(nf) ;
ke(4,9,i) =  -a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;

% ke(1,4,i) = -kx1(nf-1) - kx2(nf-1) ;
% ke(3,4,i) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
% ke(6,4,i) =  a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) + a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;
% ke(7,4,i) = -kx1(nf) - kx2(nf) ;
% ke(9,4,i) =  -a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;

%Y
%--
ke(5,2,i) = -ky1(nf-1) - ky2(nf-1) ;
ke(5,3,i) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
ke(5,5,i) = ky1(nf-1) + ky2(nf-1) + ky1(nf) + ky2(nf) ; 
ke(5,6,i) = b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) + b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;
ke(5,8,i) = -ky1(nf) - ky2(nf) ;
ke(5,9,i) =  -b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;


% ke(2,5,i) = -ky1(nf-1) - ky2(nf-1) ;
% ke(3,5,i) =  -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
% ke(6,5,i) = b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) + b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;
% ke(8,5,i) =  -ky1(nf) - ky2(nf) ;
% ke(9,5,i) = -b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;

%Theta
%-----
ke(6,1,i) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
ke(6,2,i) = -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
ke(6,3,i) = -a(nf-1)^2*0.25*( kx2(nf-1) + kx1(nf-1) ) + -b(nf-1)^2*0.25*( ky2(nf-1) + ky1(nf-1) ) ;
ke(6,4,i) =  a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) + a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;
ke(6,5,i) = b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) + b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;
ke(6,6,i) =  a(nf-1)^2*0.25*( kx2(nf-1) + kx1(nf-1) ) + b(nf-1)^2*0.25*( ky2(nf-1) + ky1(nf-1) ) + a(nf)^2*0.25*( kx2(nf) + kx1(nf) ) + b(nf)^2*0.25*( ky2(nf) + ky1(nf) ) ;
ke(6,7,i) = -a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;
ke(6,8,i) = -b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;
ke(6,9,i) =  -a(nf)^2*0.25*( kx2(nf) + kx1(nf) ) -b(nf)^2*0.25*( ky2(nf) + ky1(nf) ) ;

% ke(1,6,i) = -a(nf-1)*0.5*( kx2(nf-1) - kx1(nf-1) ) ;
% ke(2,6,i) =  -b(nf-1)*0.5*( ky2(nf-1) - ky1(nf-1) ) ;
% ke(3,6,i) =  -a(nf-1)^2*0.25*( kx2(nf-1) + kx1(nf-1) ) + -b(nf-1)^2*0.25*( ky2(nf-1) + ky1(nf-1) ) ;
% ke(7,6,i) = -a(nf)*0.5*( kx2(nf) - kx1(nf) ) ;
% ke(8,6,i) = -b(nf)*0.5*( ky2(nf) - ky1(nf) ) ;
% ke(9,6,i) = -a(nf)^2*0.25*( kx2(nf) + kx1(nf) ) + -b(nf)^2*0.25*( ky2(nf) + ky1(nf) ) ;


end


Kge(dofe(1:6,1),dofe(1:6,1),1) =  ke(1:6,1:6,1) ;
Kge(dofe(4:9,nf),dofe(4:9,nf),nf) = ke(4:9,4:9,nf) ;

for i = 2:1:nf-1

Kge(dofe(1:9,i),dofe(1:9,i),i) =  ke(1:9,1:9,i) ;


end



for  i = 1:1:nf

K = K + Kge(:,:,i) ;

end




end