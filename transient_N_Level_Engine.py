# -*- coding: utf-8 -*-
"""
Created on Sat Feb 26 20:13:15 2022

@author: taufiq
"""

import numpy as np
import numpy.linalg as la

#This code is aims to simulate the transient of Bloch-Redfield equation
def liouv_matrix(L, omega1, omega2, gammaH, gammaC, Th, Tc, p_matrix, gap, detuning, Lambda):
    N = L -2; #the number of degenerate levels
    spacing = gap/(N-1) #spacing of two quasi-degenerate level
    nh = [1/(np.exp((omega2+i*spacing)/Th)-1) for i in range(N)]
    nc = 1/(np.exp(omega1/Tc)-1)
    
    #Initialize the liouvillian
    liouv = np.zeros((L**2, L**2))
    
    #EOM for ground-state
    liouv[0,0] = -2*gammaC*nc-2*gammaH*sum(nh)
    liouv[0,L+1] = 2*gammaC*nc
    for k in range(2,N+1):
        for l in range(2,N+1):
            liouv[0, L*k+l] = 2*gammaH*p_matrix[k,l] *(1+nh[k-2])
    
    #EOM for first excited state
    liouv[L+1, L+1] = -2*gammaC*(1+nc)
    liouv[L+1, 0] = 2*gammaC*nc
    for k in range(2,N+1):
        liouv[L+1, L+k] =1j*Lambda
        liouv[L+1, k*L+1] = -i*Lambda
    
    #EOM for higher excited states
    for j in range(2,N+1):
        liouv[j*L+j,0] = 2*gammaH*nh[j-2]
        liouv[j*L+j, L+j] = -1j*Lambda
        liouv[j*L+j, j*L+1] = 1j*Lambda
        for k in range(2,N+1):
            liouv[j*L+j, L*j+k] = -gammaH*p_matrix[j,k]*(1+nh[k-2])
            liouv[j*L+j,L*k+j] =  liouv[j*L+j, L*j+k] 
            
    #EOM for external coherence