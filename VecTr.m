function [xt,yt] = VecTr(x,y,X,Y,Theta)

%===========================================================================================================================================================
%***********************************************************************************************************************************************************
%
%                                      --------------------------------------------------
%                                                          PREAMBLE
%                                      --------------------------------------------------
%
% [xt,yt] = VecTr(x,y,X,Y,theta)
%
%
%By Adarsh S, Ph.D. Candidate IIT Kanpur
%
%Description:
%------------
%This function transforms a 2-D vector to a given translation and rotation
%
%Input arguments:
%----------------
%1)x: x coordinate of vector
%2)y: y coordinate of vector
%3)X: Translation in x direction
%4)Y: Translation in y direction
%5)Theta: Rotation
%
%Output arguments:
%----------------
%1)xt: Transfromed x coordinate
%2)yt: Transfromed y coordinate
%
%Ex: [xt,yt] = VecTr(x,y,X,Y,theta) ;
%
%                                      -----------------------------------------------
%                            *********|| All rights reserved; Adarsh S; October, 2019 || *********
%                                      -----------------------------------------------
%
%
%***********************************************************************************************************************************************************
%===========================================================================================================================================================

vdum = zeros(2,1) ;

vdum = [cos(Theta) -sin(Theta) X;
    sin(Theta) cos(Theta) Y]*[x;y;1] ;

xt = vdum(1) ;
yt = vdum(2) ;

clear vdum


end