% This is function to find all the extrema

function [spmax, spmin]= extrema(in_data)
    %get data length
    dsize=length(in_data);
 
    % -----------find all the maximums------------------
    spmax(1,1) = 1;
    spmax(1,2) = in_data(1);
    jj=2;%index for data traversal
    kk=2;%to store the index of the  maximuns in the data
    while jj<dsize,
        if ( in_data(jj-1)<=in_data(jj) && in_data(jj)>=in_data(jj+1) )
            spmax(kk,1) = jj;
            spmax(kk,2) = in_data (jj);
            kk = kk+1;
        end
        jj=jj+1;
    end
    spmax(kk,1)=dsize;
    spmax(kk,2)=in_data(dsize);

    
    
    %---------edge preprocessing for the maximuxs----------
    if kk>=4
        slope1=(spmax(2,2)-spmax(3,2))/(spmax(2,1)-spmax(3,1));
        tmp1=slope1*(spmax(1,1)-spmax(2,1))+spmax(2,2);
        if tmp1>spmax(1,2)
            spmax(1,2)=tmp1;
        end
        slope2=(spmax(kk-1,2)-spmax(kk-2,2))/(spmax(kk-1,1)-spmax(kk-2,1));
        tmp2=slope2*(spmax(kk,1)-spmax(kk-1,1))+spmax(kk-1,2);
        if tmp2>spmax(kk,2)
            spmax(kk,2)=tmp2;
        end
    else
        
    end
    

    % -----------find all the minimums------------------
    spmin(1,1) = 1;
    spmin(1,2) = in_data(1);
    jj=2;%index for data traversal
    kk=2;%to store the index of the  minimums in the data
    while jj<dsize,
        if ( in_data(jj-1)>=in_data(jj) && in_data(jj)<=in_data(jj+1))
            spmin(kk,1) = jj;
            spmin(kk,2) = in_data (jj);
            kk = kk+1;
        end
        jj=jj+1;
    end
    spmin(kk,1)=dsize;
    spmin(kk,2)=in_data(dsize);
    
    
    %---------edge preprocessing for the maximuxs----------
    if kk>=4
        slope1=(spmin(2,2)-spmin(3,2))/(spmin(2,1)-spmin(3,1));
        tmp1=slope1*(spmin(1,1)-spmin(2,1))+spmin(2,2);
        if tmp1<spmin(1,2)
            spmin(1,2)=tmp1;
        end
        slope2=(spmin(kk-1,2)-spmin(kk-2,2))/(spmin(kk-1,1)-spmin(kk-2,1));
        tmp2=slope2*(spmin(kk,1)-spmin(kk-1,1))+spmin(kk-1,2);
        if tmp2<spmin(kk,2)
            spmin(kk,2)=tmp2;
        end
    else
        
    end
