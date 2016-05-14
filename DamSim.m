function varargout = DamSim(varargin)
% DAMSIM MATLAB code for DamSim.fig
%      DAMSIM, by itself, creates a new DAMSIM or raises the existing
%      singleton*.
%
%      H = DAMSIM returns the handle to a new DAMSIM or the handle to
%      the existing singleton*.
%
%      DAMSIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAMSIM.M with the given input arguments.
%
%      DAMSIM('Property','Value',...) creates a new DAMSIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DamSim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DamSim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DamSim

% Last Modified by GUIDE v2.5 28-Mar-2016 12:58:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DamSim_OpeningFcn, ...
                   'gui_OutputFcn',  @DamSim_OutputFcn, ...
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

% --- Executes just before DamSim is made visible.
function DamSim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DamSim (see VARARGIN)

% Choose default command line output for DamSim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DamSim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DamSim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in waterDemandButton.
function waterDemandButton_Callback(hObject, eventdata, handles)
% hObject    handle to waterDemandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear plot;
population = str2double(get(handles.population, 'String'));
startYear = str2double(get(handles.startYear, 'String'));
years = str2double(get(handles.years, 'String'));
growthRate = str2double(get(handles.growthRate, 'String'));
perCapita = str2double(get(handles.perCapita, 'String'));
hStart = str2double(get(handles.hStart, 'String'));
hEnd = str2double(get(handles.hEnd, 'String'));
inflowFile = get(handles.inflowFile, 'String');
mwssFile = get(handles.mwssFile, 'String');
niaFile = get(handles.niaFile, 'String');

[ xMatrix populationM waterDemandM angatCapacityM hData x2Matrix angat2 ] = Simulation(population, growthRate, startYear, years, perCapita, hStart, hEnd, inflowFile, mwssFile, niaFile);

%disp(angatCapacityM);
plotPoints(handles.plotArea, waterDemandM, xMatrix, '-');
hold(handles.plotArea, 'on');
plotPoints(handles.plotArea, angatCapacityM, xMatrix, 'r--');
hold(handles.plotArea, 'off');
legend(handles.plotArea, 'Water Demand', 'Angat Capacity', 'Location', 'southeast');

% --- Executes on button press in popButton.
function popButton_Callback(hObject, eventdata, handles)
% hObject    handle to popButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear plot;
population = str2double(get(handles.population, 'String'));
startYear = str2double(get(handles.startYear, 'String'));
years = str2double(get(handles.years, 'String'));
growthRate = str2double(get(handles.growthRate, 'String'));
perCapita = str2double(get(handles.perCapita, 'String'));
hStart = str2double(get(handles.hStart, 'String'));
hEnd = str2double(get(handles.hEnd, 'String'));
inflowFile = get(handles.inflowFile, 'String');
mwssFile = get(handles.mwssFile, 'String');
niaFile = get(handles.niaFile, 'String');

[ xMatrix populationM waterDemandM angatCapacityM hData x2Matrix angat2 ] = Simulation(population, growthRate, startYear, years, perCapita, hStart, hEnd, inflowFile, mwssFile, niaFile);
%{
disp(xMatrix);
disp(populationM);
disp(isnumeric(xMatrix));
class(populationM(1,1));
%}
% plot(handles.plotArea, xMatrix, populationM);
plotPoints(handles.plotArea, populationM, xMatrix, '-');
legend(handles.plotArea, 'Population', 'Location', 'southeast');

function plotPoints(plotArea, matrix, xMatrix, pStyle)
xMatrix = cell2mat(xMatrix);
matrix = cell2mat(matrix);
plot(plotArea, xMatrix(:, 1), matrix(:, 1), pStyle);
set(plotArea,'XMinorTick','on');
grid(plotArea, 'on');

% --- Executes on button press in simButton.
function simButton_Callback(hObject, eventdata, handles)
% hObject    handle to simButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear plot;
population = str2double(get(handles.population, 'String'));
startYear = str2double(get(handles.startYear, 'String'));
years = str2double(get(handles.years, 'String'));
growthRate = str2double(get(handles.growthRate, 'String'));
perCapita = str2double(get(handles.perCapita, 'String'));
hStart = str2double(get(handles.hStart, 'String'));
hEnd = str2double(get(handles.hEnd, 'String'));
inflowFile = get(handles.inflowFile, 'String');
mwssFile = get(handles.mwssFile, 'String');
niaFile = get(handles.niaFile, 'String');

[ xMatrix populationM waterDemandM angatCapacityM hData x2Matrix angat2 ] = Simulation(population, growthRate, startYear, years, perCapita, hStart, hEnd, inflowFile, mwssFile, niaFile);
% disp(hData);
% disp(x2Matrix);
hYears = hEnd-hStart;
disp(hData);
disp(x2Matrix);
plotPoints2(handles.waterPlot, hData, x2Matrix, hYears);
hold(handles.waterPlot, 'on');
x2Matrix = cell2mat(x2Matrix);
for i = 1:12
    plot(handles.waterPlot, x2Matrix(i, 1), cell2mat(angat2), 'r*');
end
hold(handles.waterPlot, 'off');
labels = {};
for i = hStart:hEnd
    labels = [labels num2str(i)];
end
labels = [labels 'angatCapacity'];
legend(handles.waterPlot, labels, 'Location', 'northwest');

function plotPoints2(plotArea, matrix, xMatrix, years)
xMatrix = cell2mat(xMatrix);
matrix = cell2mat(matrix);
%for i = 1:years
    %for j = 1:12
plot(plotArea, xMatrix(:, :), matrix(:, :));
        %plot(plotArea, j, matrix(i, j));
        %hold(plotArea, 'on');
    %end
    
%end
%{
for i = 1:years
    for j = 1:12
        disp(j);
        disp(matrix(i, j));
        plot(plotArea, j, matrix(i, j));
    end
end
%}
set(plotArea, 'XMinorTick', 'on');
grid(plotArea, 'on');




function population_Callback(hObject, eventdata, handles)
% hObject    handle to population (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
population = str2double(get(hObject, 'String'));
if isnan(population) || ~isreal(population) || ~(mod(population, 1) == 0)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of population as text
%        str2double(get(hObject,'String')) returns contents of population as a double

% --- Executes during object creation, after setting all properties.
function population_CreateFcn(hObject, eventdata, handles)
% hObject    handle to population (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function initialWaterLevel_Callback(hObject, eventdata, handles)
% hObject    handle to initialWaterLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initialWaterLevel = str2double(get(hObject, 'String'));
if isnan(initialWaterLevel) || ~isreal(initialWaterLevel)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of initialWaterLevel as text
%        str2double(get(hObject,'String')) returns contents of initialWaterLevel as a double


% --- Executes during object creation, after setting all properties.
function initialWaterLevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialWaterLevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function startYear_Callback(hObject, eventdata, handles)
% hObject    handle to startYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

startYear = str2double(get(hObject, 'String'));
if isnan(startYear) || ~isreal(startYear) || ~(mod(startYear, 1) == 0)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of startYear as text
%        str2double(get(hObject,'String')) returns contents of startYear as a double


% --- Executes during object creation, after setting all properties.
function startYear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function years_Callback(hObject, eventdata, handles)
% hObject    handle to years (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

years = str2double(get(hObject, 'String'));
if isnan(years) || ~isreal(years) || ~(mod(years, 1) == 0)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of years as text
%        str2double(get(hObject,'String')) returns contents of years as a double


% --- Executes during object creation, after setting all properties.
function years_CreateFcn(hObject, eventdata, handles)
% hObject    handle to years (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function growthRate_Callback(hObject, eventdata, handles)
% hObject    handle to growthRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
growthRate = str2double(get(hObject, 'String'));
if isnan(growthRate) || ~isreal(growthRate)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of growthRate as text
%        str2double(get(hObject,'String')) returns contents of growthRate as a double


% --- Executes during object creation, after setting all properties.
function growthRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to growthRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perCapita_Callback(hObject, eventdata, handles)
% hObject    handle to perCapita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

perCapita = str2double(get(hObject, 'String'));
if isnan(perCapita) || ~isreal(perCapita)
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'off');
else
    set(handles.popButton, 'String', 'Population');
    set(handles.popButton, 'Enable', 'on');
end
% Hints: get(hObject,'String') returns contents of perCapita as text
%        str2double(get(hObject,'String')) returns contents of perCapita as a double


% --- Executes during object creation, after setting all properties.
function perCapita_CreateFcn(hObject, eventdata, handles)
% hObject    handle to perCapita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hStart_Callback(hObject, eventdata, handles)
% hObject    handle to hStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hStart as text
%        str2double(get(hObject,'String')) returns contents of hStart as a double


% --- Executes during object creation, after setting all properties.
function hStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hEnd_Callback(hObject, eventdata, handles)
% hObject    handle to hEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hEnd as text
%        str2double(get(hObject,'String')) returns contents of hEnd as a double


% --- Executes during object creation, after setting all properties.
function hEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inflowFile_Callback(hObject, eventdata, handles)
% hObject    handle to inflowFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inflowFile as text
%        str2double(get(hObject,'String')) returns contents of inflowFile as a double


% --- Executes during object creation, after setting all properties.
function inflowFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inflowFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function niaFile_Callback(hObject, eventdata, handles)
% hObject    handle to niaFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of niaFile as text
%        str2double(get(hObject,'String')) returns contents of niaFile as a double


% --- Executes during object creation, after setting all properties.
function niaFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to niaFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mwssFile_Callback(hObject, eventdata, handles)
% hObject    handle to mwssFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mwssFile as text
%        str2double(get(hObject,'String')) returns contents of mwssFile as a double


% --- Executes during object creation, after setting all properties.
function mwssFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mwssFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
