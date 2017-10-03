% HS con Modificaci�n 2 Algorithm
%Por Alvaro S�nchez M�rquez
%
clc;clear all;close all
format long;
rand('twister',sum(100*clock));
%% Parametros
for celda=1:30
    celda
    
    

var=13; % Numero de variables de dise�o
Low=[ 0 0 0 0 0 0 0 0 0 0 0 0 0]; % Limite inferior de variables
High=[1 1 1 1 1 1 1 1 1 100 100 100 1]; % Limite superior de variables

%% Harmony Search Parametros

N=10;%Tama�o de la Memoria Arm�nica
%bw=(High-Low)/10;
raccept=0.99;% Concideraci�n de la MA
rpa=0.3;% Ajuste de tono
iteracion=100000;% M�ximo n�mero de iteraciones
fi=0.7;

%% Inicializaci�n
HM=zeros(N,var);
HM_new=zeros(1,var);
fobj=zeros(N,1);
factible=zeros(N,1);
for ii=1:N
    HM(ii,:)=Low+(High-Low).*rand(1,var);
    [fobj(ii,1),factible(ii,1)]=funObjg1(HM(ii,:));
end
HM      


%% Iteraci�n
for g=1:iteracion
 g
 
     
 for i=1:var

      bw=(High(i)-Low(i))/1000;  
     
     aleatorio1=rand;
     aleatorio2=rand;
     
     
      if aleatorio1<raccept
         % HSIndex=fix(rand(1)*N)+1;
         HSIndex=randperm(N,1);
         if aleatorio2<rpa
             HM_new(i)= HM(HSIndex,i)+bw*(1*rand(1)-0.5);
         else
             %% empieza procedimiento de factor inteligente
             aleatoriofi=rand;
             if aleatoriofi<fi
                 %% encuentra el mejor
                 %cont=cont+1;
                 if sum(factible)==0
                [mejorF,mejorindex]=min(fobj);
                 else
                [mejorFac,mejorindex]=min(factible);
                 end
                 HM_new(i)= HM(mejorindex,i);
             else
             HM_new(i)=HM(HSIndex,i);
             end
             %% termina pprocedimiento de factor inteligente
                        
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
  xlswrite('g1_Mod2.xlsx',tonoFinal,1,cel);
 
 clearvars -except celda
end %celda