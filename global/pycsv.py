import csv
import os.path
import scipy

def readallcsv():
    i = 0
    L=[];
    num_of_lines = 0
    name = generatename(0,5)
    p = csv.reader(open(name, 'rb'), delimiter=',')
    for row in p:
        num_of_lines = num_of_lines + 1
    
    while (os.path.isfile(generatename(i,5))):
        name = generatename(i,5)
        p = csv.reader(open(name, 'rb'), delimiter=',')
        L.append(p);
        i = i+1
        
    T = scipy.zeros((len(L),num_of_lines))
    A = scipy.zeros((len(L),num_of_lines))
    for i in xrange(len(L)):
        j = 0
        for row in L[i]:
            T[i][j]=float(row[0])
            A[i][j]=float(row[1])
            j = j + 1
        exit
    return [T,A]
    
        
        
def generatename(i, maxlen):
    return 'TEK'+(maxlen-len(str(i)))*'0'+str(i)+'.csv'
        
    
 
