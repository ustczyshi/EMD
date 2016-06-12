% This function does the EEMD decompositions of a vector

% Y: Inputted data;
% Nstd: ratio of the standard deviation of the added noise with respect to Y;
% NE: Ensemble number being used
% TNM: total number of modes (not including the trend)
%
function allmode=eemd(Y,Nstd,NE,TNM)
    % get data length
    xsize=length(Y);
    dd=1:1:xsize;
    % normalize data
    Ystd=std(Y);
    Y=Y/Ystd;
    
    % Initialize saved datas and allocate spaces for them   
    TNM2=TNM+2;
    allmode=zeros(xsize,TNM2);
    mode=zeros(xsize,TNM2);

    % loops for ensemble number NE
    for iii=1:1:NE,
        % adding noise to original datas(positive and negtive,respectively)
        temp=randn(size(Y))*Nstd;
        X1=Y+temp;
        X2=Y-temp;
        %for i=1:xsize,
            %temp=randn(1,1)*Nstd;
            %X1(i)=Y(i)+temp;
            %X2(i)=Y(i)-temp;
        %end
        
        % ---sifting X1-------------------------------
        xorigin = X1;
        xend = xorigin;
        % save the initial data into the first column
        mode(:,1) = xorigin;

        for nmode=1:TNM,            
            xstart = xend;
            for iter=1:10,
                %caculate the mean of the upper envelop and lower envelop
                [spmax, spmin]=extrema(xstart);
                upper= spline(spmax(:,1),spmax(:,2),dd);
                lower= spline(spmin(:,1),spmin(:,2),dd);
                mean_ul = (upper + lower)/2;
                
                %extract the envelop
                xstart = xstart - mean_ul;
            end
            
            %extract and save a mode
            xend = xend - xstart;
            mode(:,nmode+1) = xstart;
            
        end
        % save the trend
        mode(:,nmode+2)=xend;
        
        % add mode to the sum of modes from earlier ensemble members
        allmode=allmode+mode;
        
        
        % ---sifting X2-------------------------------
        xorigin = X2;
        xend = xorigin;
        % save the initial data into the first column
        mode(:,1) = xorigin;

        for nmode=1:TNM,            
            xstart = xend;
            for iter=1:10,
                %caculate the mean of the upper envelop and lower envelop
                [spmax, spmin]=extrema(xstart);
                upper= spline(spmax(:,1),spmax(:,2),dd);
                lower= spline(spmin(:,1),spmin(:,2),dd);
                mean_ul = (upper + lower)/2;
                
                %extract the envelop
                xstart = xstart - mean_ul;
            end
            
            %extract and save a mode
            xend = xend - xstart;
            mode(:,nmode+1) = xstart;
            
        end
        % save the trend
        mode(:,nmode+2)=xend;
        
        % add mode to the sum of modes from earlier ensemble members
        allmode=allmode+mode;

    end

    % ensemble average
    allmode=allmode/NE/2;
    % Rescale mode to origional unit.
    allmode=allmode*Ystd;