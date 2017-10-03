% PSF Algorithm
%Por Alvaro Sánchez Márquez
%
clc;clear all;close all
format long;
rand('twister',sum(100*clock));
%% Parametros
for celda=1:30
    celda
    
    

var=13; % Numero de variables de diseño
Low=[ 0 0 0 0 0 0 0 0 0 0 0 0 0]; % Limite inferior de variables
High=[1 1 1 1 1 1 1 1 1 100 100 100 1]; % Limite superior de variables

%% Harmony Search Parametros

N=10;%Tamaño de la Memoria Armónica
%bw=(High-Low)/10;
raccept=0.5;% Concideración de la MA
%rpa=0.3;% Ajuste de tono
iteracion=100000;% Máximo número de iteraciones
par=0.5;

%% Inicialización
HM=zeros(N,var);
HM_new=zeros(1,var);
fobj=zeros(N,1);
factible=zeros(N,1);
for ii=1:N
    HM(ii,:)=Low+(High-Low).*rand(1,var);
    [fobj(ii,1),factible(ii,1)]=funObjg1(HM(ii,:));
end
HM      

%peorF=max(fobj);
%[peorFac,peorindex]=max(factible);
     
%% Iteración

 %%%%%%%%% Ensayo
 for j=1:N
    for i=1:var
     bw=(High(i)-Low(i))/1000;
     
               
     aleatorio1=rand(1);
     aleatorio2=rand(1);
     
     if aleatorio1<raccept
          HSIndex=j;%fix(rand(1)*N)+1;
         if aleatorio2<par
             HM_M(j,i)= HM(HSIndex,i)+bw*(2*rand(1)-1);
         else
             HM_M(j,i)=HM(HSIndex,i);
         end
     else
         HM_M(j,i)= Low(i)+(High(i)-Low(i))*rand(1); %se genera una nueva armonia aleatoria 
     end
     
     
    end %for i
 end %for j
 
 %%%%%%%%%%% Algoritmo normal
 for g=1:iteracion
 g
 for j=1:N
    for i=1:var
     bw=(High(i)-Low(i))/1000;
     
     raccept=var*HM_M(j,i)/N;
     par=var*HM_M(j,i)/N;     
     aleatorio1=rand(1);
     aleatorio2=rand(1);
     
     if aleatorio1<raccept
          HSIndex=j;%fix(rand(1)*N)+1;
         if aleatorio2<par
             HM_new(j,i)= HM(HSIndex,i)+bw*(2*rand(1)-1);
         else
             HM_new(j,i)=HM(HSIndex,i);
         end
     else
         HM_new(j,i)= Low(i)+(High(i)-Low(i))*rand(1); %se genera una nueva armonia aleatoria 
     end
     
     
    end %for i
 
 
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % HM_new
     %%%% reajustando limites
     %%%% se reajusta el valor si es que sale fuera de limite
     OutOfBoundryH=(HM_new(j,:)>High);
     OutOfBoundryL=(HM_new(j,:)<Low);
     HM_new(j,OutOfBoundryH==1)=2*High(OutOfBoundryH==1)-HM_new(j,OutOfBoundryH==1);
     HM_new(j,OutOfBoundryL==1)=2*Low(OutOfBoundryL==1)-HM_new(j,OutOfBoundryL==1);
     
     
       
     [Nfobj,Nfac]=funObjg1(HM_new(j,:));
     
  
     
     if sum(factible)==0
      [peorF,peorindex]=max(fobj);
      peorFac=factible(peorindex,1);
     else
      [peorFac,peorindex]=max(factible);
      peorF=fobj(peorindex,1);
     end
     
     %Reglas de Deb
     if Nfac==0 && peorFac==0
        if (Nfobj<peorF)
            HM(peorindex,:)=HM_new(j,:);
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
            HM_M(peorindex,:)=HM_new(j,:);
            
        end
    elseif Nfac==0 && peorFac>0
           HM(peorindex,:)=HM_new(j,:);
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
            HM_M(peorindex,:)=HM_new(j,:);
            
     elseif Nfac<peorFac
           HM(peorindex,:)=HM_new(j,:);
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
            HM_M(peorindex,:)=HM_new(j,:);
     
     end
end %for j2 
       
  
 
 clc
    [fobj factible]
   celda
     %display(HM(j,:)') 
 end

%% Present Best Answer
    [funOpt,indice]=min(fobj);

mejor=HM(indice,:);
HM

display(mejor)
display(funOpt)
display(fobj)
    %display(factible)
  tonoFinal=[mejor funOpt];
 cel = ['A', num2str(celda)] ;
  xlswrite('g1_PSF.xlsx',tonoFinal,1,cel);
 
 clearvars -except celda
end %celda