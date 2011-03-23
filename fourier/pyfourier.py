import numpy
from numpy import *
from numpy.fft import *

def onesidefft(T,A):
    N=size(T,0)
    NP=size(T,1)
    FFT = numpy.zeros((N,NP/2+1))
    FREQ = numpy.zeros((N,NP/2+1))
    for i in xrange(N):
        timestep=T[i,2]-T[i,1]
        [FFTC, FREQC] = convfft( fft(A[i,:]), fftfreq(NP, d=timestep))
        
        FFT[i,:] = FFTC[:]
        FREQ[i,:] = FREQC[:]
    return [FFT,FREQ]
        
                   


def convfft(FFT, FREQ):
    N=size(FFT,0)
    FFTC = numpy.zeros((N/2+1))
    FREQC = numpy.zeros((N/2+1))
    for i in xrange(N/2):
        FFTC[i+1] = 0.5*(abs(FFT[i + 1])+abs(FFT[N-i-2]))
        FREQC[i+1] = 0.5*(abs(FREQ[i + 1])+ abs(FREQ[N-i-2]))
    return [FFTC, FREQC]
