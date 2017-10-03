% SGHS Algorithm
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
racceptm=0.99;% Concideración de la MA
std_raccept=0.1;
%rpa=0.3;% Ajuste de tono
iteracion=100000;% Máximo número de iteraciones
parm=0.9;
std_par=0.05;
bwmin=0.0001;
bwmax=0.1;
LP=100;
lp=1;
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
for g=1:iteracion
 g
 
 raccept=racceptm+std_raccept*(2*rand(1)-1);
     par=parm+std_par*(2*rand(1)-1);
 if g<iteracion/2
         bw=bwmax-((bwmax-bwmin)/iteracion)*2*g;
     else
         bw=bwmin;
 end
     bw
 for i=1:var
     
     
          
          
     aleatorio1=rand(1);
     aleatorio2=rand(1);
     
     
     if aleatorio1<raccept
          HSIndex=fix(rand(1)*N)+1;
         if aleatorio2<par
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
     if lp<=LP
         vRm(lp)=raccept;
         vPm(lp)=par;
     end
     if lp==LP
         lp=0;
         racceptm=sum(vRm)/LP;
         parm=sum(vPm)/LP;
     end
     lp=lp+1;
     
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
  xlswrite('g1_SGHS.xlsx',tonoFinal,1,cel);
 
 clearvars -except celda
end %celda