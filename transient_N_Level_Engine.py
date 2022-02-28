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
    liouv = np.zeros((L**2, L**2), dtype = np.complex_)
    
    #EOM for ground-state
    liouv[0,0] = -2*gammaC*nc-2*gammaH*sum(nh)
    liouv[0,L+1] = 2*gammaC*(1+nc) 
    for k in range(2,L):
        for l in range(2,L):
            liouv[0, L*k+l] = gammaH*p_matrix[k-2,l-2]*(2+nh[k-2]+nh[l-2])
    
    #EOM for first excited state
    liouv[L+1, L+1] = -2*gammaC*(1+nc)
    liouv[L+1, 0] = 2*gammaC*nc
    for k in range(2,L):
        liouv[L+1, L+k] =1j*Lambda
        liouv[L+1, k*L+1] = -1j*Lambda
    
    #EOM for higher excited states
    for j in range(2,L):
        liouv[j*L+j,0] = 2*gammaH*nh[j-2]
        liouv[j*L+j, L+j] = -1j*Lambda
        liouv[j*L+j, j*L+1] = 1j*Lambda
        for k in range(2,L):
            liouv[j*L+j, L*j+k] += -gammaH*p_matrix[j-2,k-2]*(1+nh[k-2])
            liouv[j*L+j,L*k+j] +=  liouv[j*L+j, L*j+k]
            
    #EOM for external coherence
    liouv[1, 1] = 1j*(omega1+omega2+gap/2+detuning)/2 - gammaC*(1+2*nc)
    liouv[L,L] = -1j*(omega1+omega2+gap/2+detuning)/2 - gammaC*(1+2*nc)
    for j in range(2,L):
        liouv[j,j] = 1j*((omega1+omega2-gap/2-detuning)/2+ (j-2)*gap/(N-1)) - gammaH*(1+2*nh[j-2])
        liouv[j*L, j*L] = 1j*((omega1+omega2-gap/2-detuning)/2+ (j-2)*gap/(N-1)) - gammaH*(1+2*nh[j-2])
        
        #driven external coherence
        liouv[L+j, L+j] = -gammaC*(1+nc) -1j*(detuning + gap/2+(j-2)*gap/(N-1))
        liouv[L+j, L+1] = 1j*Lambda
        liouv[j*L+1, j*L+1] = -gammaC*(1+nc) +1j*(detuning + gap/2+(j-2)*gap/(N-1))
        liouv[j*L+1, L+1] = -1j*Lambda
        for k in range(2,L):
            liouv[L+j, k*L+j] += -1j*Lambda
            liouv[L+j, j*L+k] += 1j*Lambda
            liouv[L+j, L+j] += -gammaH*(1+nh[k-2])*p_matrix[j-2,k-2]
            liouv[j*L+1, j*L+1] += -gammaH*(1+nh[k-2])*p_matrix[j-2,k-2]
            #for non-driven external
            liouv[j,j]+= -gammaH*p_matrix[j-2,k-2]*(1+nh[k-2])
            liouv[j*L, j*L] += -gammaH*p_matrix[j-2,k-2]*(1+nh[k-2])
    
    #EOM for internal coherence
    for j in range(2,L):
        for k in range(2,L):
            if j!=k:
                liouv[j*L+k, j*L+k] += 1j*(j-k)*gap/(N-1) - gammaH*(2+nh[j-2]+nh[k-2])
                #liouv[j*L+k, 0] = gammaH*(nh[j-2]+nh[k-2])*p_matrix[j-2,k-2]
                liouv[j*L+k, L+k] += -1j*Lambda
                liouv[j*L+k, j*L+1] += 1j*Lambda
                for l in range(2,L):
                    liouv[j*L+k, j*L+l] += -gammaH*(1+nh[l-2])*p_matrix[k-2, l-2]
                    liouv[j*L+k, l*L+k] += -gammaH*(1+nh[l-2])*p_matrix[j-2,l-2]
    
    return liouv

def steadystate_liouv(L, omega1, omega2, gammaH, gammaC, Th, Tc, p_matrix, gap, detuning, Lambda):
    liouv = liouv_matrix(L, omega1, omega2, gammaH, gammaC, Th, Tc, p_matrix, gap, detuning, Lambda)
    eigvals, eigvecs = la.eig(liouv)
    real_eigvals = np.real(eigvals)
    index = np.argmax(real_eigvals)
    ss = np.reshape(eigvecs[:,index],(L,L))
    ss = ss/np.trace(ss)
    return ss