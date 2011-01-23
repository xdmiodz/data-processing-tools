function [T,A] = allisfread;

N=0;
while 1
    N=N+1;
    stmp=int2str(N-1);
    for n=1:5-length(stmp)
        stmp=['0' stmp];
    end 
    filename=['TEK' stmp '.ISF'];
    if exist(filename)~=2 
        N=N-1;
        break
    end
end

    
filename='TEK00000.ISF';
[t,a]=read_tekisf(filename);

T=zeros(length(t),N);
A=zeros(length(a),N);

for k=1:N
    stmp=int2str(k-1);
    for n=1:5-length(stmp)
        stmp=['0' stmp];
    end 
    filename=['TEK' stmp '.ISF'];
    [t,a]=read_tekisf(filename);
    T(:,k)=t;
    A(:,k)=a;
end
