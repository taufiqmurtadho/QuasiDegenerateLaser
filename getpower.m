function pss = getpower(ss, omega1, omega2, gap, strength)
    pss = 0;
    for i = 3:length(ss)
        pss = pss - 2*strength*(omega2-omega1+(i-3)*gap/(length(ss)-3))*imag(ss(2,i));
    end 
end