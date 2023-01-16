function [spatial_modes,a,energy]=POD_cal_2D(U,V,n)


% this function calculates POD for given velocity field U and V,
% It is assumed U V are 2D instant velocity fields. 
% It is also assumed that the third dimension represents time.
% Calculations are done on RAM so make sure to run the code at fat nodes.
% n is the number of modes the user seeks to save.
% calculate the flactuations

VX = bsxfun(@minus, U, mean(U,3));
VY = bsxfun(@minus, V, mean(V,3));


% save only the flac
clearvars -except VX VY n



% Load LPACK libraries before hand when on linux, if on windows or mac this
% step is not needed

 svd(rand(10,10)); %pseudo code to load  matlab libraries needed for svd to avoid static TLS error, 
                    %if error continues restart matlab and re run this pseudo code.



row = size(VX,1);
col = size(VX,2);
N = size(VX,3);

TempU=reshape(VX(:),[size(VX,1)*size(VX,2),size(VX,3) ]);
TempV=reshape(VY(:),[size(VY,1)*size(VY,2),size(VY,3)]);
sizeee = size(VX,1)*size(VX,2)+size(VY,1)*size(VY,2) ;

TempUVW=reshape([TempU;TempV],[sizeee,N ]);
clear ('TempU') ; 
clear ('TempV') ; 


C=(TempUVW'*TempUVW)/N; 

clear ('TempUVW') ; 

% Calculate the eigen value of covariance matrix
[evectorC , evalueC] = svd(C); % decompose to obtain eigen value and eigen vectors of the correlation matrix

% calculate energy
energy = cumsum(diag(evalueC)/sum(diag(evalueC))*100); % calculate energy in percentage, units are (flac_vel)^2
rankC = rank(C);

%normalize the eigen vectors
for i=1:rankC
evectorC(:,i) = evectorC(:,i)/(evalueC(i,i)^0.5);
end

%
disp('Calculating spatial mode');

% the vectorized version requires memory, in case short of memory run the
% neseted code.
phiX = reshape((evectorC' * reshape(VX,[row*col,N])')', [row,col,N]);
phiY = reshape((evectorC' * reshape(VY,[row*col,N])')', [row,col,N]);


% 
% % % Calculate POD basis 
%  phiX = zeros(row,col,N);
%  phiY = zeros(row,col,N);
% for i=1:rank(C)
%     totalX = zeros(row,col,1);
%     totalY = zeros(row,col,1);
%     for j=1:N
%         totalX = totalX + evectorC(j,i)*VX(:,:,j); % U velocity vector basis
%         totalY = totalY + evectorC(j,i)*VY(:,:,j);  % V velocity vector basis
%     end
%     phiX(:,:,i) = totalX;
%     phiY(:,:,i) = totalY;
% end

% save n modes as seeked by the user
spatial_modes=[]; 


spatial_modes.phiU=(phiX(:,:,1:n));
spatial_modes.phiV=(phiY(:,:,1:n));


%% Time series of the mode
disp('Calculating Temporal mode');

% % Time coefficients


% Time coefficients
a = zeros(rank(C),N);
for i=1:rank(C)
    a(i,:) = sum(VX(:,:,:).*phiX(:,:,i)+VY(:,:,:).*phiY(:,:,i),[1,2])/N;
end   








% % reconstruction if needed in the future
% VXhat = zeros(size(VX));
% VYhat = zeros(size(VY));
% for j=1:N
% for i=1:100
%     
% VXhat(:,:,j)= VXhat(:,:,j) + a(i,j).*phiX(:,:,i);
% VYhat(:,:,j)= VYhat(:,:,j) + a(i,j).*phiY(:,:,i);
% end
% end    
