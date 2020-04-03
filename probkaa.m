function varargout = probkaa(varargin)
%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @probkaa_OpeningFcn, ...
    'gui_OutputFcn',  @probkaa_OutputFcn, ...
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


% --- Executes just before probkaa is made visible.
function probkaa_OpeningFcn(hObject, eventdata, handles, varargin)
tic;
handles.pozycja=varargin{3};
set(handles.ekran,'Position',handles.pozycja);

handles.pozostalo=varargin{2};

handles.czas=0;
set(handles.niewybuchy,'String',handles.pozostalo);
handles.rozmiar=varargin{1};
handles.wymiarKwadratu=50;
handles.luka=0.5;
handles.wynik=0;
set(handles.wynikk, 'Visible','off','String',handles.wynik);
set(handles.sprawdzenie,'visible','off');

handles.flaga=imread('flag.jpg');

for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        handles.kwadraciki(y,x)=uicontrol('Fontsize',1,'Foreground','black','String','0','style','pushbutton','position',[handles.wymiarKwadratu*(x),handles.wymiarKwadratu*(handles.rozmiar+3-y),handles.wymiarKwadratu-handles.luka,handles.wymiarKwadratu-handles.luka],'CallBack', @otwieranie,'CDATA',imread('snow.png'));
        if x==1 || y==1 || x==handles.rozmiar+2 || y==handles.rozmiar+2
            set(handles.kwadraciki(y,x),'visible','off');
        end
    end
end

handles.iloscMin=varargin{2};
i=1;
while (i<=handles.iloscMin)
    x=randi([2,handles.rozmiar],1,1);
    y=randi([2,handles.rozmiar],1,1);
    if (get(handles.kwadraciki(x,y),'String')~='B')
        set(handles.kwadraciki(x,y),'String','B');
        i=i+1;
    end
end

% pozosta³a plansza

numer=1;
while (numer<=(handles.rozmiar+2)^2)
    dobraPlansza=handles.rozmiar+2;
    wynik=0;
    pola=[numer-dobraPlansza-1,numer-dobraPlansza,numer-dobraPlansza+1,numer-1,numer+1,numer+dobraPlansza-1,numer+dobraPlansza,numer+dobraPlansza+1];
    warunek = find(pola>0 & pola<dobraPlansza*dobraPlansza);
    
    koniec = length(warunek);
    % sprawdzanie poszczególnych pól w poszukiwaniu min
    if(get(handles.kwadraciki(numer),'String')=='B')
        numer=numer+1;
    else
        for jedynka=pola(warunek(1:koniec))
            if(get(handles.kwadraciki(jedynka),'String')=='B')
                wynik=wynik+1;
            end
        end
        set(handles.kwadraciki(numer),'String',num2str(wynik))
        numer=numer+1;
        
    end
end

for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        if(get(handles.kwadraciki(y,x),'String')=='B')
            set(handles.kwadraciki(y,x),'Callback',{@but,handles,'bum.png'})
        else
            set(handles.kwadraciki(y,x),'Callback',{@nieBomby,handles})
        end
        set(handles.kwadraciki(y,x),'buttondownfcn',{@flagowanie,handles,'snow.png'})
    end
end


% Choose default command line output for probkaa
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = probkaa_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


function nieBomby(hObject, EventData,handles)
if (~strcmp((char(get(hObject,'CData'))),char(handles.flaga)))
    set(hObject,'FontSize',30,'Foreground','black');
    if(get(hObject,'String')=='0')
        set(hObject,'String','-');
        pozycja=get(hObject,'position');
        zerowki(handles,pozycja);
    end
end



function zerowki(handles,pozycja)

kolumna=pozycja(1,1);
wiersz=pozycja(1,2);

obreb=[kolumna-50,wiersz-50;kolumna,wiersz-50;kolumna+50,wiersz-50;kolumna-50,wiersz;kolumna+50, wiersz;kolumna-50,wiersz+50;kolumna,wiersz+50;kolumna+50,wiersz+50];

for xx=2:handles.rozmiar+1
    for yy=2:handles.rozmiar+1
        for i=1:8
            obszar=get(handles.kwadraciki(yy,xx),'Position');
            punkty=obszar(1,1:2);
            sprawdzenie=obreb(i,:);
            if(punkty==sprawdzenie)
                set(handles.kwadraciki(yy,xx),'FontSize',30,'Foreground','Black');
                if(get(handles.kwadraciki(yy,xx),'String')=='0')
                    set(handles.kwadraciki(yy,xx),'String','-');
                    nowka=get(handles.kwadraciki(yy,xx),'Position');
                    zerowki(handles,nowka);
                end 
            end
        end
    end
end



    


function flagowanie(hObject, EventData,handles,tlo)
if(get(hObject,'FontSize')~=30)
    cos=tlo;
    if (strcmp((char(get(hObject,'CData'))),char(handles.flaga)))
        set(hObject,'CDATA',imread(cos));
        handles.pozostalo=str2double(get(handles.niewybuchy,'String'))+1;
        set(handles.niewybuchy, 'String',handles.pozostalo);
    else
        set(hObject,'CDATA',handles.flaga);
        handles.pozostalo=str2double(get(handles.niewybuchy,'String'))-1;
        set(handles.niewybuchy, 'String', handles.pozostalo);
    end
    if(handles.pozostalo<0)
        set(handles.niewybuchy,'visible','off');
        set(handles.tekst, 'String', 'Zaznaczono za du¿o min ');
        set(handles.sprawdzenie,'visible','off');
    elseif(handles.pozostalo>0)
        set(handles.niewybuchy,'visible','on');
        set(handles.tekst, 'String', 'Iloœæ min do odnalezienia: ');
        set(handles.sprawdzenie,'visible','off');
    else
        set(handles.niewybuchy,'visible','off');
        set(handles.tekst, 'String', 'Sprawdzamy? ');
        set(handles.sprawdzenie,'visible','on');
    end
end
guidata(hObject, handles);


function but(hObject,eventdata,handles,obraz)

% podœwietlanie wszystkich liczb
if (~strcmp((char(get(hObject,'CData'))),char(handles.flaga)))
    for xx=1:handles.rozmiar+2
        for yy=1:handles.rozmiar+2
            if (get(handles.kwadraciki(yy,xx),'String')=='B')
                set(handles.kwadraciki(yy,xx),'String','','CDATA',imread(obraz))
            end
            set(handles.kwadraciki(yy,xx),'Fontsize',30,'Foreground','black')
        end
    end
    przegrana = questdlg('Niestety przegra³eœ !','Rezultat','Zagraj ponownie','Poddaj siê','Poddaj siê');
    switch przegrana
        case 'Zagraj ponownie'
            level();
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
        case 'Poddaj siê'
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
    end
end

% --- Executes on button press in sprawdzenie.
function sprawdzenie_Callback(hObject, eventdata, handles)
for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        if(get(handles.kwadraciki(y,x),'String')=='B' && strcmp((char(get(handles.kwadraciki(y,x),'CData'))),char(handles.flaga)));
            handles.wynik=str2double(get(handles.wynikk,'String'))+1;
            set(handles.wynikk,'String',handles.wynik);
        end
    end
end
guidata(hObject, handles);
if(str2double(get(handles.wynikk,'String'))~=handles.iloscMin)
    przegrana = questdlg('Niestety przegra³eœ !','Przegrana','Zagraj ponownie','Poddaj siê','Poddaj siê');
    switch przegrana
        case 'Zagraj ponownie'
            level();
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
        case 'Poddaj siê'
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
    end
else
    handles.czas = toc;
    wygrana = questdlg('Gratulacje wygra³eœ !','Wygrana','Zagraj ponownie','Poddaj siê','Zapisz wynik','Zapisz wynik');
    switch wygrana
        case 'Zagraj ponownie'
            level();
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
        case 'Poddaj siê'
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
        case 'Zapisz wynik'
            zapis(handles.czas,handles.iloscMin);
            close(probkaa(handles.rozmiar,handles.iloscMin,handles.pozycja));
    end
end


% --------------------------------------------------------------------
function Menu_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function tryb_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function peace_Callback(hObject, eventdata, handles)
handles.tlo='kwiat.png';
for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        if(~strcmp((char(get(handles.kwadraciki(y,x),'CData'))),char(handles.flaga)))
            set(handles.kwadraciki(y,x),'CDATA',imread('kwiat.png'))
        end
        if(get(handles.kwadraciki(y,x),'String')=='B')
            set(handles.kwadraciki(y,x),'Callback',{@but,handles,'serce.png'})
        end
        set(handles.kwadraciki(y,x),'buttondownfcn',{@flagowanie,handles,'kwiat.png'});
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function war_Callback(hObject, eventdata, handles)
handles.tlo='cam.png';
for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        if(~strcmp((char(get(handles.kwadraciki(y,x),'CData'))),char(handles.flaga)))
            set(handles.kwadraciki(y,x),'CDATA',imread('cam.png'))
        end
        if(get(handles.kwadraciki(y,x),'String')=='B')
            set(handles.kwadraciki(y,x),'Callback',{@but,handles,'atom.jpg'})
        end
        set(handles.kwadraciki(y,x),'buttondownfcn',{@flagowanie,handles,'cam.png'});
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function winter_Callback(hObject, eventdata, handles)
for x=1:handles.rozmiar+2
    for y=1:handles.rozmiar+2
        if(~strcmp((char(get(handles.kwadraciki(y,x),'CData'))),char(handles.flaga)))
            set(handles.kwadraciki(y,x),'CDATA',imread('snow.png'))
        end
        if(get(handles.kwadraciki(y,x),'String')=='B')
            set(handles.kwadraciki(y,x),'Callback',{@but,handles,'bum.png'})
        end
        set(handles.kwadraciki(y,x),'buttondownfcn',{@flagowanie,handles,'snow.png'});
    end
end
guidata(hObject, handles);
