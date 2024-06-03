function varargout = Baseline_Wander_estimation(varargin)
% Baseline_Wander_estimation MATLAB code for Baseline_Wander_estimation.fig
%      Baseline_Wander_estimation, by itself, creates a new Baseline_Wander_estimation or raises the existing
%      singleton*.
%
%      H = Baseline_Wander_estimation returns the handle to a new Baseline_Wander_estimation or the handle to
%      the existing singleton*.
%
%      Baseline_Wander_estimation('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Baseline_Wander_estimation.M with the given input arguments.
%
%      Baseline_Wander_estimation('Property','Value',...) creates a new Baseline_Wander_estimation or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Baseline_Wander_estimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Baseline_Wander_estimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Baseline_Wander_estimation

% Last Modified by GUIDE v2.5 03-Jun-2024 15:18:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Baseline_Wander_estimation_OpeningFcn, ...
    'gui_OutputFcn',  @Baseline_Wander_estimation_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Baseline_Wander_estimation is made visible.
function Baseline_Wander_estimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Baseline_Wander_estimation (see VARARGIN)

% Choose default command line output for Baseline_Wander_estimation
handles.output = hObject;
axes(handles.axes4);
imshow(fullfile('Aux functions and tools','Images','upm.png'));
axes(handles.axes3);
imshow(fullfile('Aux functions and tools','Images','byo.png'));
addpath(genpath('./'))
set(handles.checkbox1,'Enable','off')
set(handles.checkbox2,'Enable','off')
set(handles.checkbox3,'Enable','off')
set(handles.checkbox4,'Enable','off')
set(handles.checkbox5,'Enable','off')
set(handles.checkbox6,'Enable','off')
set(handles.checkbox7,'Enable','off')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Baseline_Wander_estimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Baseline_Wander_estimation_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




%% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
value = get(hObject,'Value');
if value
    if handles.EMDBW == 0
        [imf,r] = emd(handles.Gaze_L);
        [~,N]=size(imf);
        EMD_L =sum(imf(:,N-5:N),2)+r;
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.emdL = plot(EMD_L ,'LineWidth',1.5,'DisplayName', ['EMD']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
        [imf,r] = emd(handles.Gaze_R);
        [~,N]=size(imf);
        EMD_R =sum(imf(:,N-5:N),2)+r;
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.emdR = plot(EMD_R ,'LineWidth',1.5,'DisplayName', ['EMD']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.EMDBW =1;
        guidata(hObject,handles);
        
    end
    set(handles.emdL,'HandleVisibility','on')
    set(handles.emdR,'HandleVisibility','on')
    set(handles.emdL,'Visible','on')
    set(handles.emdR,'Visible','on')
else
    set(handles.emdL,'HandleVisibility','off')
    set(handles.emdR,'HandleVisibility','off')
    set(handles.emdL,'Visible','off')
    set(handles.emdR,'Visible','off')
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
value = get(hObject,'Value');
if value
    if handles.VMDBW == 0
        h = waitbar(0.1,' VMD is runining for Left eye ...');
        tic
        
        [imf,~] = vmd(handles.Gaze_L);
        [~,N] = size(imf);
        VMD_L = sum(imf(:,N),2);
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.vmdL = plot(VMD_L ,'LineWidth',1.5,'DisplayName', ['VMD']);
        hold(handles.axes1,'off')
        
        h = waitbar(0.5,h,' VMD is runining for Right eye...');
        
        [imf,~] = vmd(handles.Gaze_R);
        [~,N] = size(imf);
        VMD_R = sum(imf(:,N),2);
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.vmdR = plot(VMD_R ,'LineWidth',1.5,'DisplayName', ['VMD']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.VMDBW =1;
        guidata(hObject,handles);
        
        h = waitbar(0.98,h, sprintf('Elapsed time is %.3g sec', toc));
        pause(2)
        close(h)
    end
    
    set(handles.vmdL,'HandleVisibility','on')
    set(handles.vmdR,'HandleVisibility','on')
    set(handles.vmdL,'Visible','on')
    set(handles.vmdR,'Visible','on')
else
    set(handles.vmdL,'HandleVisibility','off')
    set(handles.vmdR,'HandleVisibility','off')
    set(handles.vmdL,'Visible','off')
    set(handles.vmdR,'Visible','off')
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
value = get(hObject,'Value');

if value
    if handles.FDMBW == 0
        
        Fs = 1000;
        tm = (0:length(handles.Gaze_L)-1)/Fs;
        cleansig_FDM = sp_DFTOrthogonalOrFIR_IIR_LINOEP(handles.Gaze_L,tm ,Fs, 0.6 ,'dft');
        FDM_L =cleansig_FDM {1, 2};
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.fdmL = plot(FDM_L ,'LineWidth',1.5,'DisplayName', ['FDM']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
        
        tm = (0:length(handles.Gaze_R)-1)/Fs;
        cleansig_FDM = sp_DFTOrthogonalOrFIR_IIR_LINOEP(handles.Gaze_R,tm ,Fs, 0.6 ,'dft');
        FDM_R =cleansig_FDM {1, 2};
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.fdmR = plot(FDM_R ,'LineWidth',1.5,'DisplayName', ['FDM']);
        guidata(hObject,handles);
        hold(handles.axes2,'off')
        
        handles.FDMBW =1;
        guidata(hObject,handles);
        
    end
    
    
    set(handles.fdmL,'HandleVisibility','on')
    set(handles.fdmR,'HandleVisibility','on')
    set(handles.fdmL,'Visible','on')
    set(handles.fdmR,'Visible','on')
else
    set(handles.fdmL,'HandleVisibility','off')
    set(handles.fdmR,'HandleVisibility','off')
    set(handles.fdmL,'Visible','off')
    set(handles.fdmR,'Visible','off')
end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
value = get(hObject,'Value');
if value
    if handles.EWTBW == 0
        [mra,~] = ewt(handles.Gaze_L,'MaxNumPeaks',3);
        EWT_L = sum(mra(:,3),2);
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.ewtL = plot(EWT_L ,'LineWidth',1.5,'DisplayName', ['EWT']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
        [mra,~] = ewt(handles.Gaze_R,'MaxNumPeaks',3);
        EWT_R = sum(mra(:,3),2);
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.ewtR = plot(EWT_R ,'LineWidth',1.5,'DisplayName', ['EWT']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.EWTBW =1;
        guidata(hObject,handles);
        
    end
    set(handles.ewtL,'HandleVisibility','on')
    set(handles.ewtR,'HandleVisibility','on')
    set(handles.ewtL,'Visible','on')
    set(handles.ewtR,'Visible','on')
else
    set(handles.ewtL,'HandleVisibility','off')
    set(handles.ewtR,'HandleVisibility','off')
    set(handles.ewtL,'Visible','off')
    set(handles.ewtR,'Visible','off')
end

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
value = get(hObject,'Value');

if value
    if handles.MAFBW == 0
        
        MAF_L = movmean(handles.Gaze_L,600);
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.mafL = plot(MAF_L ,'LineWidth',1.5,'DisplayName', ['MAF']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
        MAF_R = movmean(handles.Gaze_R,600);
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.mafR = plot(MAF_R ,'LineWidth',1.5,'DisplayName', ['MAF']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.MAFBW =1;
        guidata(hObject,handles);
        
    end
    set(handles.mafL,'HandleVisibility','on')
    set(handles.mafR,'HandleVisibility','on')
    set(handles.mafL,'Visible','on')
    set(handles.mafR,'Visible','on')
else
    set(handles.mafL,'HandleVisibility','off')
    set(handles.mafR,'HandleVisibility','off')
    set(handles.mafL,'Visible','off')
    set(handles.mafR,'Visible','off')
end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
value = get(hObject,'Value');

if value
    if handles.IIRBW == 0
        
       Fs = 1000;
        Fc = 0.5;
        [b,a] = butter(4,Fc/(Fs/2),'high');
        IIR_L =  handles.Gaze_L - filtfilt (b,a,handles.Gaze_L);
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.iirL = plot(IIR_L ,'LineWidth',1.5,'DisplayName', ['IIR']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
IIR_R =  handles.Gaze_R - filtfilt (b,a,handles.Gaze_R);        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.iirR = plot(IIR_R ,'LineWidth',1.5,'DisplayName', ['IIR']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.IIRBW =1;
        guidata(hObject,handles);
        
    end
    set(handles.iirL,'HandleVisibility','on')
    set(handles.iirR,'HandleVisibility','on')
    set(handles.iirL,'Visible','on')
    set(handles.iirR,'Visible','on')
else
    set(handles.iirL,'HandleVisibility','off')
    set(handles.iirR,'HandleVisibility','off')
    set(handles.iirL,'Visible','off')
    set(handles.iirR,'Visible','off')
end

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
value = get(hObject,'Value');

if value
    if handles.EMD2BW == 0
        
        Fs = 1000;
        EMD2_L =  handles.Gaze_L - EMDRemoveBL( handles.Gaze_L,Fs, 0.9,5);
        axes(handles.axes1);
        hold(handles.axes1,'on')
        handles.emd2L = plot(EMD2_L ,'LineWidth',1.5,'DisplayName', ['EMD2']);
        guidata(hObject,handles);
        hold(handles.axes1,'off')
        
        EMD2_R =  handles.Gaze_R - EMDRemoveBL( handles.Gaze_R,Fs, 0.9,5);
        axes(handles.axes2);
        hold(handles.axes2,'on')
        handles.emd2R = plot(EMD2_R ,'LineWidth',1.5,'DisplayName', ['EMD2']);
        guidata(hObject,handles);
        hold(handles.axes2,'on')
        
        handles.EMD2BW =1;
        guidata(hObject,handles);
        
    end
    set(handles.emd2L,'HandleVisibility','on')
    set(handles.emd2R,'HandleVisibility','on')
    set(handles.emd2L,'Visible','on')
    set(handles.emd2R,'Visible','on')
else
    set(handles.emd2L,'HandleVisibility','off')
    set(handles.emd2R,'HandleVisibility','off')
    set(handles.emd2L,'Visible','off')
    set(handles.emd2R,'Visible','off')
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
addpath(genpath('./'))
RadioButton=get(handles.uibuttongroup2,'SelectedObject');
StringName = get(RadioButton, 'String');
if strcmp(StringName,'Baseline wander estimation')

    set(handles.checkbox1,'Value',0.0)
    set(handles.checkbox2,'Value',0.0)
    set(handles.checkbox3,'Value',0.0)
    set(handles.checkbox4,'Value',0.0)
    set(handles.checkbox5,'Value',0.0)
    set(handles.checkbox6,'Value',0.0)
    set(handles.checkbox7,'Value',0.0)

    set(handles.checkbox1,'Enable','off')
    set(handles.checkbox2,'Enable','off')
    set(handles.checkbox3,'Enable','off')
    set(handles.checkbox4,'Enable','off')
    set(handles.checkbox5,'Enable','off')
    set(handles.checkbox6,'Enable','off')
    set(handles.checkbox7,'Enable','off')

    cla(handles.axes1,'reset')
    cla(handles.axes2,'reset')

    a1= get(hObject,'Value');
    if (a1==1)
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        f = errordlg(' \fontsize{17} Please Select a file','File Error', CreateStruct);
        % f = errordlg(' Please Select a file','File Error');
        return
    elseif (a1==2)
        f = fullfile('Data','HF011');
    elseif (a1==3)
        f = fullfile('Data','HG023');
    elseif (a1==4)
        f = fullfile('Data','HG051');
    elseif (a1==5)
        f = fullfile('Data','HG059');
    end

    data = load(f);
    xL = data.Gaze_L;
    Gaze_L = (xL - min(xL))/(max(xL)-min(xL));
    GT_L = (data.GT_L - min(xL))/(max(xL)-min(xL));
    Target_L = (data.Target - min(xL))/(max(xL)-min(xL));

    xR = data.Gaze_R;
    Gaze_R = (xR - min(xR))/(max(xR)-min(xR));
    GT_R = (data.GT_R - min(xR))/(max(xR)-min(xR));
    Target_R = (data.Target - min(xR))/(max(xR)-min(xR));

    handles.EMDBW = 0;
    handles.VMDBW = 0;
    handles.FDMBW = 0;
    handles.EWTBW = 0;
    handles.MAFBW = 0;
    handles.IIRBW = 0;
    handles.EMD2BW = 0;

    handles.Gaze_L = Gaze_L;
    handles.Gaze_R = Gaze_R;
    guidata(hObject,handles);

    %% plot left signals
    axes(handles.axes1);
    plot(Target_L,'--', 'LineWidth',1.5,'DisplayName', ['Target'])
    hold on
    plot(Gaze_L,'LineWidth',1.5,'DisplayName', ['Gaze'])
    plot(GT_L,'LineWidth',1.5,'DisplayName', ['GT'])
    legend();
    newChr = strrep(f,'.mat','');
    newChr = strrep(newChr,'Data','');
    newChr = strrep(newChr,'\','');
    newChr = strrep(newChr,'/','');
    title(sprintf('Left eye of %s', newChr))
    xlabel('Time (ms)')
    ylabel('Amplitude')
    grid on
    grid minor
    ylim([-0.05 1.05])
    hold off

    %% plot Right signals
    axes(handles.axes2);
    plot(Target_R,'--','LineWidth',1.5,'DisplayName', ['Target'])
    hold on
    plot(Gaze_R,'LineWidth',1.5,'DisplayName', ['Gaze'])
    plot(GT_R,'LineWidth',1.5,'DisplayName', ['GT'])
    legend();
    title(sprintf('Right eye of %s', newChr))
    xlabel('Time (ms)')
    ylabel('Amplitude')
    grid on
    grid minor
    ylim([-0.05 1.05])
    hold off

    set(handles.checkbox1,'Enable','on')
    set(handles.checkbox2,'Enable','on')
    set(handles.checkbox3,'Enable','on')
    set(handles.checkbox4,'Enable','on')
    set(handles.checkbox5,'Enable','on')
    set(handles.checkbox6,'Enable','on')
    set(handles.checkbox7,'Enable','on')
else
    String = get(handles.popupmenu1,'String');%Groups
    file = String{get(handles.popupmenu1,'Value')};
    f = fullfile('Data',strcat(file,'.mat'));
    if isfile(f)
        data = load(f);
    else
        CreateStruct.Interpreter = 'tex';
        CreateStruct.WindowStyle = 'modal';
        e = errordlg(' \fontsize{17} Please Select a file','File Error', CreateStruct);
        return;
    end

    %-------------- BW removal --------------------------------------------
    %X axis
    [mra,~] = ewt(data.Gaze_L(:,1),'MaxNumPeaks',3);
    level = select_level(data.Target(:,1),mra);
    EWT_L_X = sum(mra(:,level),2);
    if level ~= 3
        EWT_L_X = sum(mra(:,2),2) + sum(mra(:,3),2);
    end

    [mra,~] = ewt(data.Gaze_R(:,1),'MaxNumPeaks',3);
    level = select_level(data.Target(:,1),mra);
    EWT_R_X = sum(mra(:,level),2);

    if level ~= 3
        EWT_R_X = sum(mra(:,2),2) + sum(mra(:,3),2);
    end
    
    %------------ ICA decomposition ----------------------------------
    
    X_x =  [data.Gaze_L(:,1)-EWT_L_X,data.Gaze_R(:,1)-EWT_R_X];
    Xn = zscore(X_x);
    OBJ = rica(Xn,2);
    ICAtrans_X = Xn*OBJ.TransformWeights;


   %-----------------------------------------------------------------
    %Remove the beginning and ending of the serie
    i = 501;
    l = 14500;
    x = linspace(1,l-i+1,l-i+1);

    %------------------- CERM selection -----------------------------
    g = [ICAtrans_X(i:l,1);
        ICAtrans_X(i:l,2)];
    maxi_i = max(g);
    mini_i = min(g);
    %-----------------------------------------------------
    X = X_x(i:l,:);
    maxi_x = max(X,[],'all');
    mini_x = min(X,[],'all');
    %-----------------------------------------------------
    C1 = maxmin_norm(ICAtrans_X(i:l,1),maxi_i,mini_i);
    C2 = maxmin_norm(ICAtrans_X(i:l,2),maxi_i,mini_i);
    var1 = (std(C1))^2;
    var2 = (std(C2))^2;

    s1 = maxmin_norm(X(:,1),maxi_x,mini_x);
    s2 = maxmin_norm(X(:,2),maxi_x,mini_x);


    %% Check correlation with original signals and adjust sign
    corr_ic1_s1 = corr(C1, s1);
    corr_ic1_s2 = corr(C1, s2);

    if abs(corr_ic1_s1) > abs(corr_ic1_s2)
        if corr_ic1_s1 < 0
            C1 = 1-C1;
        end
    else
        if corr_ic1_s2 < 0
            C1 = 1-C1;
        end
    end

    corr_ic2_s1 = corr(C2, s1);
    corr_ic2_s2 = corr(C2, s2);
    if abs(corr_ic2_s1) > abs(corr_ic2_s2)
        if corr_ic2_s1 < 0
            C2 = 1-C2;
        end
    else
        if corr_ic2_s2 < 0
            C2 = 1-C2;
        end
    end
    %--------
    if var1 >= var2
        CERM_X = C1;
        NO_CERM_X = C2;

    else
        CERM_X = C2;
        NO_CERM_X = C1;
    end
    
    %-------------------------- Plots -------------------------------------
    axes(handles.axes1);
    plot(x,s1,'Color','b')
    hold on;
    plot(x,s2,'Color','r')
    legend({'$s_{1}[n]$','$s_{2}[n]$'},'Interpreter','latex','Location','best','FontSize',14);
    legend('boxoff')
    ylabel('Norm. Amp.','FontSize',12)
    xlabel('Time (ms)','FontSize',12)
    hold off;
    
    axes(handles.axes2);
    plot(x,CERM_X,'Color','b')
    hold on;
    plot(x,NO_CERM_X,'Color','r')
    legend({'CERM','NO\_CERM'},'Interpreter','latex','Location','best','FontSize',14);
    legend('boxoff')
    ylabel('Norm. Amp.','FontSize',12)
    xlabel('Time (ms)','FontSize',12)
    hold off;

end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
RadioButton=get(handles.uibuttongroup2,'SelectedObject');
StringName = get(RadioButton, 'String');
if strcmp(StringName,'Baseline wander estimation')
    set(handles.text6,'Visible','on');
    set(handles.uipanel1,'Visible','on');
    set(handles.popupmenu1,'Value',1);

    set(handles.checkbox1,'Value',0.0)
    set(handles.checkbox2,'Value',0.0)
    set(handles.checkbox3,'Value',0.0)
    set(handles.checkbox4,'Value',0.0)
    set(handles.checkbox5,'Value',0.0)
    set(handles.checkbox6,'Value',0.0)
    set(handles.checkbox7,'Value',0.0)

    set(handles.checkbox1,'Enable','off')
    set(handles.checkbox2,'Enable','off')
    set(handles.checkbox3,'Enable','off')
    set(handles.checkbox4,'Enable','off')
    set(handles.checkbox5,'Enable','off')
    set(handles.checkbox6,'Enable','off')
    set(handles.checkbox7,'Enable','off')

else
    set(handles.text6,'Visible','off');
    set(handles.uipanel1,'Visible','off');
    set(handles.popupmenu1,'Value',1);
    
end
