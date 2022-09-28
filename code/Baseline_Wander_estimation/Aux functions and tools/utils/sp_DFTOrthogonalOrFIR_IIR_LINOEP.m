%{{{{
function ImfByFilter=sp_DFTOrthogonalOrFIR_IIR_LINOEP(X,t,Fs,CutFrq,varargin)
   
    if(CutFrq(1)==0) % new implementation [0,...,Fs/2] with backward compatibility
        CutFrq=CutFrq(2:end-1); % discard 0 & Fs/2 as required by code implementation
        CutFrq=sort(CutFrq,'descend'); % as required by code implementation
    end
   [m,n] = size(X);
   if(m<n) % convert row data to coloumn data
       X=X';
   end
   
   % use DFT and DCT based filter or LINOEP filters fo FIR
   FFTFilter=0; DCTFilter=0;  FIRFilter=0;    IIRFilter=0;
    
   if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'DFT','dft'}))      
       FFTFilter=1;         
   end
   
   if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'DCT','dct'}))      
       DCTFilter=1;         
   end
   
   if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'FIR','fir'}))
        FIRFilter=1;        
   end
   
   if (nargin > 1 && ischar(varargin{end})) && any(strcmpi(varargin{end},{'IIR','iir'}))
        IIRFilter=1;        
   end 
   cofsize=300;
   if(FIRFilter==1)
        if(length(t)>cofsize*3)
            FilCofSize=cofsize;
        else
            FilCofSize=fix((length(t)/4))-1;    
        end   
   end
    
    periodicallyExtendData=1; % 1 for periodically Extend Data to tackale end effects
    if DCTFilter
        periodicallyExtendData=0;
    end
    
    if(periodicallyExtendData==1) 
        NbOfRows=fix(length(t)*2/100); % 2% append
        AppendData=flipud(X(1:NbOfRows,:));
        PadData=flipud(X(end-NbOfRows+1:end,:));    
        Filt_X=[AppendData; X; PadData]; % periodically extend data to remove end effects
        X=Filt_X;
        tmp_length=length(Filt_X(:,1)); % nb of rows
    end
    
    NbOfLoop=length(CutFrq);

    for loop=1:NbOfLoop       
        Fcut=CutFrq(loop); 
        %d =fdesign.highpass('n,fc',10,9600,48000);
        %d =fdesign.lowpass('n,fc',300,.10,Fs);
        
            
            if(FIRFilter==1)
                d =fdesign.highpass('n,fc',FilCofSize,Fcut,Fs); 
                % FIR window design. Fc is 6-dB down point.
                Hd = design(d);
            end    
            if(IIRFilter==1) % IIR filter
                %Order 8 and 3 dB frequency 0.6*pi radians/sample
                Fcut1=Fcut/(Fs/2);
                d = fdesign.highpass('N,F3dB',12,Fcut1);                
                Hd = design(d,'butter');
                %fvtool(Hd)
            end        
        
        %fvtool(Hd);     

        for NbOfchannel=1:length(X(1,:))
            if FFTFilter
                Y1(:,NbOfchannel)=sp_IFFT_Filter(X(:,NbOfchannel),Fs,Fcut,'HP'); % OK, zero phase filtering is must; DFT is also a zero-phase filtering 
            end
            if DCTFilter 
                Y1(:,NbOfchannel)=sp_DCT2_Filter(X(:,NbOfchannel),Fs,Fcut,'HP'); % OK, zero phase filtering is must; DCT is also a zero-phase filtering 
            end
            if FIRFilter
                Y1(:,NbOfchannel)=filtfilt(Hd.Numerator,1,X(:,NbOfchannel)); % OK, zero phase filtering is must
                %Y1(:,NbOfchannel)=filter(Hd.Numerator,1,X(:,NbOfchannel)); % conventional filtering NOT OK at all
            end
            if IIRFilter
                Y1(:,NbOfchannel)=filtfilt(Hd.sosMatrix,Hd.ScaleValues,X(:,NbOfchannel)); % OK, zero phase filtering is must
            end
            
        end      

        if DCTFilter  
            R1=X-real(Y1);
        else
            R1=X-Y1;
        end
        %ImfByFilter{loop}=Y1;
        
        %%{{{
        if(FFTFilter==0) % If not FFT Filter then get LINOEP
            %R1% LF
            %Y1% HF
            % orthogonality check first
            %tt=(sum(Y1.*R1));
            
            tmp1=(sum(Y1.*R1));
            tmp2=(sum(R1.*R1));
            alpha=tmp1/tmp2;
            tp1=(1+alpha)*R1; % LP
            tp2=Y1-alpha*R1; % HP-a*LP            
            R1=tp1; Y1=tp2;
            
            % orthogonality check at last
            %tt1=(sum(Y1.*R1));
        end 
        %%%}}}
        if(periodicallyExtendData==1)
            ImfByFilter{loop}=Y1((NbOfRows+1):(tmp_length-NbOfRows),:); % remove added Data i.e. make org size of signal ;
        else
             ImfByFilter{loop}=Y1;
        end
        X=R1;
    end
%ImfByFilter{loop+1}=R1; % residue
 if(periodicallyExtendData==1)
    ImfByFilter{loop+1}=R1((NbOfRows+1):(tmp_length-NbOfRows),:); % remove added Data i.e. make org size of signal ;
 else
     ImfByFilter{loop+1}=R1;
 end
%}}}