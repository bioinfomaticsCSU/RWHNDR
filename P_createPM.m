function [ PMatrix ] = P_createPM( ft_Wrd,ft_Wtd,fpara_a,fpara_b,fpara_dn,fpara_test_d_index )
    dr = length(ft_Wrd);
    dt = length(ft_Wtd);
    dn = fpara_dn;
    
    P0 = zeros(dr+dt+dn,1);
	
    numR = sum(ft_Wrd);
    if(numR~=0)
        P0(1:dr) = ft_Wrd/numR;
    end
    
    numT = sum(ft_Wtd);
    if(numT~=0)
        P0(dr+1:dr+dt) = ft_Wtd/numT;
    end
    
    P0(dr+dt+fpara_test_d_index) = 1;
    
    P0(1:dr) = fpara_a*P0(1:dr);
    P0(dr+1:dr+dt) = fpara_b*P0(dr+1:dr+dt);
    P0(dr+dt+1:dr+dt+dn) = (1-fpara_a-fpara_b)*P0(dr+dt+1:dr+dt+dn);
    
    PMatrix = P0;
end

