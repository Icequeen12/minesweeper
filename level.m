function varargout = level(varargin)
% LEVEL MATLAB code for level.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @level_OpeningFcn, ...
                   'gui_OutputFcn',  @level_OutputFcn, ...
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


% --- Executes just before level is made visible.
function level_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to level (see VARARGIN)

% Choose default command line output for level
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes level wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = level_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in easy.
function easy_Callback(hObject, eventdata, handles)
handles.pozycja=[100,100,80,30];
handles.rozmiar=5;
handles.iloscMin=5;
probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja);
guidata(hObject, handles);
close(level);



% --- Executes on button press in half.
function half_Callback(hObject, eventdata, handles)
handles.pozycja=[70,100,120,50];
handles.rozmiar=10;
handles.iloscMin=25;
probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja);
guidata(hObject, handles);
close(level);


% --- Executes on button press in Asian.
function Asian_Callback(hObject, eventdata, handles)
handles.pozycja=[60,10,160,70];
handles.rozmiar=14;
handles.iloscMin=45;
probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja);
guidata(hObject, handles);
close(level);
    
    
