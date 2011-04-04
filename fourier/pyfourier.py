import numpy
from numpy import *
from numpy.fft import *

def onesidefft(T,A):
    N=size(T,0)
    NP=size(T,1)
    FFT = numpy.zeros((N,NP/2))
    FREQ = numpy.zeros((N,NP/2))
    for i in xrange(N):
        timestep=T[i,2]-T[i,1]
        [FFTC, FREQC] = convfft( fft(A[i,:]-mean(A[i,:])), fftfreq(NP, d=timestep))
        
        FFT[i,:] = FFTC[:]
        FREQ[i,:] = FREQC[:]
    return [FFT,FREQ]
        
                   


def convfft(FFT, FREQ):
    N=size(FFT,0)
    FFTC = numpy.zeros((N/2))
    FREQC = numpy.zeros((N/2))
    for i in xrange(N/2):
        FFTC[i] = 0.5*(abs(FFT[i])+abs(FFT[N-i-1]))
        FREQC[i] = 0.5*(abs(FREQ[i])+ abs(FREQ[N-i-1]))
    return [FFTC, FREQC]

def normfft(FFT,FREQ):
     N=size(FFT,0)
     NP=size(FFT,1)
     for i in xrange(N):
         for j in xrange(NP):
             FFT[i,j]=FFT[i,j]/FREQ[i,j]
     return [FFT, FREQ]
