function ss = getSteadyState(system_size, omega1, omega2, gammaH, gammaC, Th, Tc, pmatrix, gap, detuning, strength)
    %Obtain the steady-state as python array
    ssRe_py = py.N_Level_Engine_v2.getSteadyStateRe(py.int(system_size), omega1, omega2, gammaH, gammaC, Th, Tc, pmatrix, gap, detuning, strength);
    ssIm_py = py.N_Level_Engine_v2.getSteadyStateIm(py.int(system_size), omega1, omega2, gammaH, gammaC, Th, Tc, pmatrix, gap, detuning, strength);
    %Convert to matlab doubles
    ssRe_mat = double(py.array.array('d',py.numpy.nditer(ssRe_py)));
    ssRe_mat = reshape(ssRe_mat, [system_size, system_size]);
    ssIm_mat = double(py.array.array('d',py.numpy.nditer(ssIm_py)));
    ssIm_mat = reshape(ssIm_mat, [system_size, system_size]);
    ss = ssRe_mat + 1i*ssIm_mat;
end