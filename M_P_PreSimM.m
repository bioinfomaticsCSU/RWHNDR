function [ TranMat ] = M_P_PreSimM(fWdd,fWrr,fWtt,fWdr,fWdt,fWrt,fparasMat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dr = size(fWrr,1);
dn = size(fWdd,1);
dt = size(fWtt,1);

fWrd = fWdr';
fWtd = fWdt';
fWtr = fWrt';

Mdd = zeros(dn,dn);
Mrr = zeros(dr,dr);
Mtt = zeros(dt,dt);
Mdr = zeros(dn,dr);
Mrd = zeros(dr,dn);
Mdt = zeros(dn,dt);
Mtd = zeros(dt,dn);
Mrt = zeros(dr,dt);
Mtr = zeros(dt,dr);

fa_rd = fparasMat(1);
fa_dr = fparasMat(1);
fa_rt = fparasMat(2);
fa_tr = fparasMat(2);
fa_td = fparasMat(3);
fa_dt = fparasMat(3);

for i=1:dr
    num1 = 0;
    num2 = 0;
    numAs_d = sum(fWrd(i,:));
    if(numAs_d~=0)
        num1 = 1;
    end
    numAs_t = sum(fWrt(i,:));
    if(numAs_t~=0)
        num2 = 1;
    end
    numAs = numAs_d + numAs_t;
    numSum = sum(fWrr(i,:));
    if(numAs==0)
      for j=1:dr
          Mrr(i,j) = fWrr(i,j)/numSum;
      end
    else
        for j=1:dr
            Mrr(i,j) = (1-num1*fa_rd-num2*fa_rt)*fWrr(i,j)/numSum;
        end
    end
end

for i=1:dn
    num1 = 0;
    num2 = 0;
    numAs_r = sum(fWdr(i,:));
    if(numAs_r~=0)
        num1 = 1;
    end
    numAs_t = sum(fWdt(i,:));
    if(numAs_t~=0)
        num2 = 1;
    end
    numAs = numAs_r + numAs_t;
    numSum = sum(fWdd(i,:));
    if(numAs==0)
      for j=1:dn
          Mdd(i,j) = fWdd(i,j)/numSum;
      end
    else
        for j=1:dn
            Mdd(i,j) = (1-num1*fa_dr-num2*fa_dt)*fWdd(i,j)/numSum;
        end
    end
end

for i=1:dt
    num1 = 0;
    num2 = 0;
    numAs_d = sum(fWtd(i,:)) ;
    if(numAs_d~=0)
        num1 = 1;
    end
    numAs_r = sum(fWtr(i,:));
    if(numAs_r~=0)
        num2 = 1;
    end
    numAs = numAs_d + numAs_r;
    numSum = sum(fWtt(i,:));
    if(numAs==0)
      for j=1:dt
          Mtt(i,j) = fWtt(i,j)/numSum;
      end
    else
        for j=1:dt
            Mtt(i,j) = (1-num1*fa_td-num2*fa_tr)*fWtt(i,j)/numSum;
        end
    end
end

for i=1:dr
    numAs = sum(fWrd(i,:));
    if(numAs==0)
      Mrd(i,:) = 0;
    else
        for j=1:dn
            Mrd(i,j) = fa_rd*fWrd(i,j)/numAs;
        end
    end
end

for i=1:dn
    numAs = sum(fWdr(i,:));
    if(numAs==0)
      Mdr(i,:) = 0;
    else
        for j=1:dr
            Mdr(i,j) = fa_dr*fWdr(i,j)/numAs;
        end
    end
end

for i=1:dr
    numAs = sum(fWrt(i,:));
    if(numAs==0)
      Mrt(i,:) = 0;
    else
        for j=1:dt
            Mrt(i,j) = fa_rt*fWrt(i,j)/numAs;
        end
    end
end

for i=1:dt
    numAs = sum(fWtr(i,:));
    if(numAs==0)
      Mtr(i,:) = 0;
    else
        for j=1:dr
            Mtr(i,j) = fa_tr*fWtr(i,j)/numAs;
        end
    end
end

for i=1:dn
    numAs = sum(fWdt(i,:));
    if(numAs==0)
      Mdt(i,:) = 0;
    else
        for j=1:dt
            Mdt(i,j) = fa_dt*fWdt(i,j)/numAs;
        end
    end
end

for i=1:dt
    numAs = sum(fWtd(i,:));
    if(numAs==0)
      Mtd(i,:) = 0;
    else
        for j=1:dn
            Mtd(i,j) = fa_td*fWtd(i,j)/numAs;
        end
    end
end

TranMat = [Mrr Mrt Mrd; Mtr Mtt Mtd; Mdr Mdt Mdd];

end

