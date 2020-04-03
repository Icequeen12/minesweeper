function varargout = zapis(varargin)
% ZAPIS MATLAB code for zapis.fig



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zapis_OpeningFcn, ...
                   'gui_OutputFcn',  @zapis_OutputFcn, ...
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


% --- Executes just before zapis is made visible.
function zapis_OpeningFcn(hObject, eventdata, handles, varargin)


handles.wynik=varargin{1};
set(handles.czas,'String',num2str(handles.wynik));
set(handles.girl,'CData',imread('girl.jpg'));
handles.imie='TUTAJ';

handles.miny=varargin{2};

handles.poziom='';
if(handles.miny==45)
    handles.poziom='Azjata';
elseif(handles.miny==25)
    handles.poziom='Œredni';
else
    handles.poziom='£atwy';
end




% Choose default command line output for zapis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


function varargout = zapis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
varargout{1} = handles.output;


% --- Executes on button press in zapis.
function zapis_Callback(hObject, eventdata, handles)
czas=num2str(handles.wynik);
login=handles.imie;


expr= '[\[\(\)\{\+\*\.\^\\\?\$\|\s ]';
match=regexp(login,expr,'match');

if(isempty(handles.imie)==1 || strcmp(handles.imie,'TUTAJ'))
    set(handles.opss,'Visible','On');
else
    if(isempty(match)==1)
        plikID=fopen('wyniki.txt');
        wyniki=textscan(plikID,'%s', 'HeaderLines',1);
        przerwa={'-'};
        
        wyniki{1}{end+1}=strcat(login,przerwa,czas,'s',przerwa,handles.poziom);
        
        WINNERS=wyniki{1,1};
        
        tabela=cell2table(WINNERS);
        
        writetable(tabela,'wyniki.txt')
        Decyzja = questdlg('Co teraz ?','Decyzja','Zagraj ponownie','Poddaj siê','Poddaj siê');
        switch Decyzja
            case 'Zagraj ponownie'
                close();
                level();
            case 'Poddaj siê'
                close();
        end
    else
        set(handles.opss,'Visible','On');
    end
end

function nick_Callback(hObject, eventdata, handles)
handles.imie=get(hObject,'String');
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function nick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nick (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in girl.
function girl_Callback(hObject, eventdata, handles)

set(hObject,'CData',imread('spanish.png'));
guidata(hObject, handles);
