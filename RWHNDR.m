clear;

Wrr = importdata('DrugSimMat');
Wdd = importdata('DiseaseSimMat');
Wtt = importdata('TargetSimMat.mat');
Wdr = importdata('DiDrAMat');
Wrd = Wdr';
Wrt = importdata('DrTaAMat.mat');
Wtr = Wrt';
Wdt = importdata('DiTaAMat.mat');
Wtd = Wdt';

dn = size(Wdd,1);
dr = size(Wrr,1);
dt = size(Wtt,1);

r = 0.7;
para_a = 0.8;
para_b = 0.1;

t_rd = 0.6;
t_rt = 0.3;
t_dt = 0.3;

ParasMat = [t_rd,t_rt,t_dt];

Result_Mat = zeros(dr,dn);

%trasition matrix;
M = M_P_PreSimM(Wdd,Wrr,Wtt,Wdr,Wdt,Wrt,ParasMat);
Mt = M';
    
for test_d_index = 1:dn
    disp('test_d_index.............................');
    disp(test_d_index);
    %predict candidate drugs for the test_d_index disease;
    P0 = P_createPM(Wrd(:,test_d_index),Wtd(:,test_d_index),para_a,para_b,dn,test_d_index);
    
    Pt = P0;
    nPt = (1-r)*Mt*Pt + r*P0;
    dist_diff = pdist2(nPt',Pt','cityblock');
    
    while(dist_diff>10^-10)
        Pt = nPt;
        nPt = (1-r)*Mt*Pt + r*P0;
        dist_diff = pdist2(nPt',Pt','cityblock');
    end
    
    result_P = nPt(1:dr);
    
    Result_Mat(:,test_d_index) = result_P;
end

save('Result_Mat.mat','Result_Mat');
