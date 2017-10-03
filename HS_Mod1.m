% HS con Modificación 1 Algorithm
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
raccept=0.99;% Concideración de la MA
rpa=0.3;% Ajuste de tono
iteracion=100000;% Máximo número de iteraciones
a=0.8;

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

     
%% Iteración
for g=1:iteracion
 g
 
     
 for i=1:var
    
          bw=(High(i)-Low(i))/(g^a);
     aleatorio1=rand(1);
     aleatorio2=rand(1);
     
     
     if aleatorio1<raccept
          HSIndex=fix(rand(1)*N)+1;
         if aleatorio2<rpa
             HM_new(i)= HM(HSIndex,i)+bw*(2*rand(1)-1);
         else
             HM_new(i)=HM(HSIndex,i);
         end
     else
         HM_new(i)= Low(i)+(High(i)-Low(i))*rand(1); %se genera una nueva armonia aleatoria 
     end
 end
 % HM_new
     %%%% reajustando limites
     %%%% se reajusta el valor si es que sale fuera de limite
     OutOfBoundryH=(HM_new>High);
     OutOfBoundryL=(HM_new<Low);
     HM_new(OutOfBoundryH==1)=2*High(OutOfBoundryH==1)-HM_new(OutOfBoundryH==1);
     HM_new(OutOfBoundryL==1)=2*Low(OutOfBoundryL==1)-HM_new(OutOfBoundryL==1);
     
     
       
     [Nfobj,Nfac]=funObjg1(HM_new);
     
     
     
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
            HM(peorindex,:)=HM_new;
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
            
        end
    elseif Nfac==0 && peorFac>0
           HM(peorindex,:)=HM_new;
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
            
     elseif Nfac<peorFac
           HM(peorindex,:)=HM_new;
            fobj(peorindex,1)=Nfobj;
            factible(peorindex,1)=Nfac;
     
     end
 
 
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
  xlswrite('g1_Mod1.xlsx',tonoFinal,1,cel);
 
 clearvars -except celda
end %celda