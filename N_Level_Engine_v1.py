import numpy as np
import numpy.linalg as la
import numpy.random as random
import scipy.stats
#from scipy import optimize
#################################################################################
def steadystate_linsystem(system_size, omega1, omega2, gammaH, gammaC, Th, Tc,
                        p_matrix, gap, detuning, Lambda):
    #This function will return [A,b] where steady-state
    #subspace x satisfies Ax = b
    N = system_size -2; #the number of degenerate levels
    spacing = gap/(N-1) #spacing of two quasi-degenerate level
    nh = [1/(np.exp((omega2+i*spacing)/Th)-1) for i in range(N)]
    nc = 1/(np.exp(omega1/Tc)-1)
    #Calculating the column vector coefficients b
    b = np.zeros((N+1)**2)
    #b[0] = -2*nc*gammaC
    for i in range(N+1):
        if i == 0:
            b[i] = -2*nc*gammaC
        else:
            b[(N+2)*i] = -2*gammaH*nh[i-1]
            for j in range(i+1, N+1):
                b[i+(N+1)*j] += -gammaH*(nh[i-1]+nh[j-1])*p_matrix[i-1, j-1]
                b[j+(N+1)*i] += -gammaH*(nh[i-1]+nh[j-1])*p_matrix[j-1,i-1]
    #Initiating coefficient matrix A
    A = np.zeros(((N+1)**2, (N+1)**2),dtype = 'complex')
    #Population equation
    #Filling the first row
    A[0,0] += -2*gammaC*(1+nc)
    for i in range(N+1):
        A[0,(N+2)*i] += -2*gammaC*nc
        if i > 0:
            A[0, i] += Lambda*1j
            A[0, (N+1)*i] += -Lambda*1j

    #Filling the other excited states population
    for i in range(1,N+1):
        A[(N+2)*i, (N+1)*i] = Lambda*1j
        A[(N+2)*i,i] = -Lambda*1j
        A[(N+2)*i, (N+2)*i] += -2*gammaH*(1+nh[i-1])
        for j in range(N+1):
            A[(N+2)*i, (N+2)*j]+= -2*gammaH*nh[i-1]
            if j>0 and j!=i:
                A[(N+2)*i, i+(N+1)*j] += -gammaH*p_matrix[i-1, j-1]*(1+nh[j-1])
                A[(N+2)*i, j+(N+1)*i] += -gammaH*p_matrix[i-1, j-1]*(1+nh[j-1])
    #Non-degenerate coherences
    for i in range(1, N+1):
        A[i,i] +=  -gammaH*(1+nh[j-1])-gammaC*(1+nc)+1j*((i-1)*spacing-gap/2-detuning)
        A[i,0] += 1j*Lambda
        A[(N+1)*i, (N+1)*i] = -gammaH*(1+nh[j-1])-gammaC*(1+nc)-1j*((i-1)*spacing-gap/2-detuning)
        A[(N+1)*i,0] += -1j*Lambda
        for j in range(1, N+1):
            A[i, i+(N+1)*j] += -1j*Lambda
            A[(N+1)*i,j+(N+1)*i] += 1j*Lambda
            if i!=j:
                A[i, j] += -gammaH*p_matrix[j-1, i-1]*(1+nh[j-1])
                A[(N+1)*i, (N+1)*j] += -gammaH*p_matrix[j-1, i-1]*(1+nh[j-1])

    #Degenerate coherences
    for i in range(1,N+1):
        for j in range(1,N+1):
            if i!=j:
                #print((i,j))
                A[j+(N+1)*i, j+(N+1)*i]+= 1j*(j-i)*spacing-gammaH*(2+nh[i-1]+nh[j-1])
                A[j+(N+1)*i, j] += -1j*Lambda
                A[j+(N+1)*i, (N+1)*i] += 1j*Lambda
                for k in range(N+1):
                    A[j+(N+1)*i, (N+2)*k] += -gammaH*p_matrix[i-1, j-1]*(nh[i-1]+nh[j-1])
                    if k>0:
                        if k!=j:
                            A[j+(N+1)*i, k+(N+1)*i] += -gammaH*(1+nh[j-1])*p_matrix[j-1, k-1]
                        if k!=i:
                            A[j+(N+1)*i, j+(N+1)*k] += -gammaH*(1+nh[i-1])*p_matrix[k-1, i-1]
    return [A,b]

##############################################################################################
def getSteadyState(system_size, omega1, omega2, gammaH, gammaC, Th, Tc, 
                        p_matrix, gap, detuning, Lambda):
    
    #This function returns the steady state density matrix given the parameter
    
    #Getting the appropriate linear system and solving it
    [A,b] = steadystate_linsystem(system_size, omega1, omega2, gammaH, gammaC, Th, Tc, 
                        p_matrix, gap, detuning, Lambda)
    subSteadyState = np.reshape(la.solve(A,b), (system_size-1, system_size-1))
    
    #Setting infinitesimal values (below numpy precision) to be zero
    tol = 10**(-14)
    subSteadyState.real[abs(subSteadyState.real) < tol] = 0
    subSteadyState.imag[abs(subSteadyState.imag) < tol] = 0
    
    #Sum the diagonals to find the ground state population
    sum_of_diagonals = 0
    for i in range(len(subSteadyState)):
        sum_of_diagonals+=subSteadyState[i,i]
    steadyState = np.pad(subSteadyState, (1,0))
    steadyState[0,0] = 1- sum_of_diagonals
    
    #Testing for Hermiticity
    for i in range(system_size-1):
        check = 0
        for j in range(i+1, system_size-1):
            if np.abs(np.conj(subSteadyState[i,j])-subSteadyState[j,i])>10**(-13):
                print("WARNING: the steady-state is not Hermitian")
                print(np.abs(np.conj(subSteadyState[i,j])-subSteadyState[j,i]))
                check+=1
                break
        if check >0:
            break
    
    #Testing for positivity
    eigenvals = la.eigvals(steadyState)
    for x in eigenvals:
        check = 0
        if x<0 and abs(x)>tol:
            print("WARNING: the steady-state is not positive")
            print(x)
            check+=1
            print(min(la.eigvals(p_matrix)))
            break
        if check > 0:
            break
    
    return steadyState

##########################################################################################
def powerSS(steadystate, omega1, omega2, gap, Lambda):
    #This function computes power of the engine given the steady-state
    power = 0
    for i in range(len(steadystate)-2):
        power+=-2*Lambda*(omega2-omega1+i*gap/(len(steadystate)-3))*steadystate[1,i+2].imag
    return power

def hotbath_coh_heatCurrentSS(steadyState, omega2, gammaH, Th, p_matrix, gap):
    size = len(steadyState)
    heatCurrent = 0
    omegas = [omega2+(i-2)*gap for i in range(2,size)]
    nh = [1/(np.exp(omegas[i-2]/Th)-1) for i in range(2,size)]
    for i in range(2,size):
        for j in range(i+1,size):
            heatCurrent+= -gammaH*((1+nh[i-2])*omegas[j-2]+(1+nh[j-2])*omegas[i-2])*p_matrix[i-2,j-2]*(steadyState[i,j]+steadyState[j,i])
    return np.real(heatCurrent)

def hotbath_incoh_heatCurrentSS(steadyState, omega2, gammaH, Th, p_matrix, gap):
    size = len(steadyState)
    heatCurrent = 0
    omegas = [omega2+(i-2)*gap for i in range(2,size)]
    nh = [1/(np.exp(omegas[i-2]/Th)-1) for i in range(2,size)]
    for i in range(2,size):
        heatCurrent+=2*gammaH*omegas[i-2]*(nh[i-2]*steadyState[0,0]-(1+nh[i-2])*steadyState[i,i])
    return np.real(heatCurrent)


def hotbath_heatCurrentSS(steadyState, omega2, gammaH, Th, p_matrix, gap):
    size = len(steadyState)
    heatCurrent = 0
    omegas = [omega2+(i-2)*gap for i in range(2,size)]
    nh = [1/(np.exp(omegas[i-2]/Th)-1) for i in range(2,size)]
    for i in range(2,size):
        heatCurrent+=2*gammaH*omegas[i-2]*(nh[i-2]*steadyState[0,0]-(1+nh[i-2])*steadyState[i,i])
    for i in range(2,size):
        for j in range(i+1,size):
            heatCurrent+= -gammaH*((1+nh[i-2])*omegas[j-2]+(1+nh[j-2])*omegas[i-2])*p_matrix[i-2,j-2]*(steadyState[i,j]+steadyState[j,i])
    return np.real(heatCurrent)

def coldbath_heatCurrentSS(steadyState, omega1, gammaC, Tc):
    nc = 1/(np.exp(omega1/Tc)-1)
    return np.real(2*omega1*gammaC*(nc*steadyState[0,0]-(1+nc)*steadyState[1,1]))


################################################################################
def uniform_correlation_matrix(N):
    #This is a function to generate a correlation matrix by uniformly sampling dipole angular orientation
    corr_matrix = np.identity(N)
    theta = [random.uniform(0,np.pi) for i in range(N-1)] #Sampling polar angles
    phi = [random.uniform(0,2*np.pi) for i in range(N-1)] #Sampling azimuthal angles
    for i in range(N-1):
        corr_matrix[0,i+1] = np.cos(theta[i])
        corr_matrix[i+1,0] = corr_matrix[0,i+1]
    for i in range(1,N-1):
        for j in range(i+1, N):
            corr_matrix[i,j] = np.sin(theta[i-1])*np.sin(theta[j-1])*np.cos(phi[i-1]-phi[j-1])+np.cos(theta[j-1])*np.cos(theta[i-1])
            corr_matrix[j,i] = corr_matrix[i,j]
    return(corr_matrix)

#LKJ Sampling
#This function samples a correlation matrix from an LKJ distribution
#Code is written by Ben Lambert and Fergus Cooper in the app "Distribution Zoo"
#https://ben18785.shinyapps.io/distribution-zoo/
def lkj_sampling(nu, d, n=1):
    r_list = []
    for i in range(n):
        if d==1:
            r = np.array(1)
        elif d==2:
            rho = 2 * scipy.stats.beta.rvs(nu, nu, 0, 1, 1) - 1
            r = np.array([[1, rho], [rho, 1]])
        else:
            beta = nu + (d - 2.0) / 2.0
            u = float(scipy.stats.beta.rvs(beta, beta, 0, 1, 1))
            r_12 = 2 * u - 1
            r = np.array([[1, r_12], [r_12, 1]])
            for m in range(1, d - 1):
                beta -= 0.5
                y = scipy.stats.beta.rvs((m + 1) / 2.0, beta, 0, 1, 1)
                a = scipy.stats.norm.rvs(0, 1, (m + 1))
                anorm = np.sqrt(np.sum(a**2))
                u = a / anorm
                w = np.sqrt(y) * u
                A = scipy.linalg.cholesky(r)
                z = np.matmul(w, A)
                z.shape = (len(z), 1)
                r = np.block([[r, z], [z.transpose(), 1]])
        r_list.append(r)
    return r_list
##########################################################################################
#def smax(steadystate):
    #This function computes maximum synchronization measure
#   size = len(steadystate)
#    N = size-2 #the number of quasi-degenerate levels
#    ss_coherences = [steadystate[1,i] for i in range(2,size)]
#    for i in range(2,size):
#        for j in range(i+1, size):
#            ss_coherences.append(steadystate[i,j])
#    
    #define the objective function (the function to maximize) 
#   def objective_function(phases):
#        norm_coherences = [np.abs(x) for x in ss_coherences]
#        arg_coherences = [np.angle(x) for x in ss_coherences]
#        func = 0
#       for i in range(N):
#            func += norm_coherences[i]*np.cos(phases[i]+arg_coherences[i])
#        index = 0
#        for i in range(N):
#            for j in range(N-i-1):
#                func += norm_coherences[N+index+j]*np.cos(phases[i+j+1]-phases[i]+arg_coherences[N+index+j])
#            index+=N-i-1
#        return func
#    x0 = [0]*N
#    bounds = [(-np.pi, np.pi)]*N
#    result = optimize.shgo(objective_function, bounds = bounds)
#   return result
##############################################################################################
def phase_distribution(steadystate):
    N = len(steadystate)
    def Q_function(phases):
        res = 0
        if len(phases) == N - 2:
            for i in range(1,N):
                for j in range(i+1, N):
                    if i == 1:
                        res+=np.real(steadystate[i,j]*np.exp(1j*phases[j-2]))
                    else:
                        res+=np.real(steadystate[i,j]*np.exp(1j*(phases[j-2]-phases[i-2])))
        return res
    return Q_function