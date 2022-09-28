%function FilteredData1=sp_IFFT_Filter(data_xn,Fs,fc,varargin) % FFT based Intrinsic Mode Decomposition 
function FilteredData1=sp_IFFT_Filter(data_xn,Fs,varargin) % FFT based Intrinsic Mode Decomposition 
    %Fs=1/(t(2)-t(1)); % sampling frequency
    %OrgDataEnergy=sum(data_xn.*data_xn);
    FigureEnable=0;
    gaindB=0;
    [RowData,ColomnData] = size(data_xn); % change data to row vector   
    if(RowData>ColomnData)
        data_xn=data_xn';   
    end    
    L=length(data_xn);
    if 0
        %tic
        NFFT = 2^nextpow2(L); % Next power of 2 from length of y
        N=(NFFT);
        Xk=fft(data_xn,NFFT)/L;
        %toc
    else
        %tic
        NFFT=ceil(L/2)*2; % make it even
        %NFFT=L;    
        N=(NFFT);
        Xk=fft(data_xn,NFFT)/L;  % /N because of Matlab FFT & IFFT formulae
        %toc
    end
    
    if FigureEnable
    freq = Fs/2*linspace(0,1,NFFT/2+1);
    DataFFT=2*abs(Xk(1:NFFT/2+1));
    % Plot single-sided amplitude spectrum.
    %figure
    subplot(2,1,1);
    if gaindB
    plot(freq,20*log10(DataFFT)); 
    else
    plot(freq,(DataFFT)); 
    end
    title('Data FFT plot');
    end    
    
    %fc=Fs*k/N => k=fc*N/Fs
    %range_k=ceil(fc*N/Fs);
    %range_k=round(fc*N/Fs); % convert fc to k (digital freq)
    Hk=zeros(1,N);
    if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'LP','lp'})),
        if strcmpi(varargin{end},'LP'),
            fc=varargin{end-1};
            range_k=round(fc*N/Fs); % convert fc to k (digital freq)
            kk{1}=1:range_k; % for low pass filter   
            kk{2}=(N-range_k+1):N; % for low pass filter
            Hk(kk{1})=1;
            Hk(kk{2})=1;
            
            Xk((range_k+1):N/2)=0;
            Xk((N/2+1):(N-range_k))=0;
            
        end
        %varargin(end)=[];
    end
    
    if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'HP','hp'})),
        if strcmpi(varargin{end},'HP'),
            fc=varargin{end-1};
            range_k=round(fc*N/Fs); % convert fc to k (digital freq)            
            kk{1}=(range_k+1):N/2; % for High pass filter   
            kk{2}=(N/2+1):(N-range_k); % High low pass filter  
            Hk(kk{1})=1;
            Hk(kk{2})=1;
            
            Xk(1:range_k)=0;
            Xk((N-range_k+1):N)=0;
            
        end
        %varargin(end)=[];
    end
    if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'BP','bp'})),
        if strcmpi(varargin{end},'BP'),
            fc1=varargin{end-2};
            fc2=varargin{end-1};
            range_k1=round(fc1*N/Fs); % convert fc to k (digital freq) 
            range_k2=round(fc2*N/Fs); % convert fc to k (digital freq)
            kk{1}=(range_k1+1):range_k2; % for High pass filter   
            kk{2}=(N-range_k2):(N-range_k1-1); % High low pass filter  
            Hk(kk{1})=1;
            Hk(kk{2})=1;
            
            Xk(1:range_k1)=0;
            Xk(range_k2:N/2)=0;
            
            Xk((N-range_k1+1):N)=0;
            Xk((N/2+1):(N-range_k2+1))=0;         
            
        end 
        %varargin(end)=[];
    end 
    
    if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'BS','bs'})),
        if strcmpi(varargin{end},'BS'),
            Hk=ones(1,N);
            fc1=varargin{end-2};
            fc2=varargin{end-1};
            range_k1=round(fc1*N/Fs); % convert fc to k (digital freq) 
            range_k2=round(fc2*N/Fs); % convert fc to k (digital freq)
            kk{1}=(range_k1+1):range_k2; % for High pass filter   
            kk{2}=(N-range_k2):(N-range_k1-1); % High low pass filter  
            Hk(kk{1})=0;
            Hk(kk{2})=0;
            
            Xk(range_k1:range_k2)=0;
            Xk(N-range_k2-1:N-range_k1-1)=0;               
        end
        %varargin(end)=[];
    end    
    
    if 0
        IMFs_y=zeros(N,1);
        for n=1:N
        %n=1:N;
            IMFs_y(n,1)=sum(Xk(kk{1}).*exp(1i*2*pi*(kk{1}-1)*(n-1)/N));   
            %IMFs_y(n,2)=(1/N)*sum(Xk(kk{2}).*exp(1i*2*pi*(kk{2}-1)*(n-1)/N)); 
        end            
        %FilteredData=IMFs_y(:,1)+IMFs_y(:,2);  
        %FilteredData=real(FilteredData);
        FilteredData=2*real(IMFs_y);    
    else
        %IMFs_y=ifft(Hk.*Xk)*L;
        IMFs_y=ifft(Xk)*L;
        FilteredData=real(IMFs_y);
    end
    if FigureEnable
    Xk=fft(FilteredData,NFFT)/N;     
    freq = Fs/2*linspace(0,1,NFFT/2+1);
    DataFFT=2*abs(Xk(1:NFFT/2+1));
    % Plot single-sided amplitude spectrum.
    %figure
    subplot(2,1,2);
    if gaindB 
    plot(freq,20*log10(DataFFT));
    else        
    plot(freq,DataFFT);
    end
    title('Filtered Data FFT plot'); 
    end
    FilteredData1=FilteredData(1:L); 
    
    
    