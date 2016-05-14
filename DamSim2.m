function varargout = DamSim2(varargin)
% DAMSIM2 MATLAB code for DamSim2.fig
%      DAMSIM2, by itself, creates a new DAMSIM2 or raises the existing
%      singleton*.
%
%      H = DAMSIM2 returns the handle to a new DAMSIM2 or the handle to
%      the existing singleton*.
%
%      DAMSIM2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAMSIM2.M with the given input arguments.
%
%      DAMSIM2('Property','Value',...) creates a new DAMSIM2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DamSim2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DamSim2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DamSim2

% Last Modified by GUIDE v2.5 25-Apr-2016 14:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DamSim2_OpeningFcn, ...
                   'gui_OutputFcn',  @DamSim2_OutputFcn, ...
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


% --- Executes just before DamSim2 is made visible.
function DamSim2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DamSim2 (see VARARGIN)

% Choose default command line output for DamSim2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DamSim2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DamSim2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function population_Callback(hObject, eventdata, handles)
% hObject    handle to population (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function perCapita_Callback(hObject, eventdata, handles)
% hObject    handle to perCapita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function startYear_Callback(hObject, eventdata, handles)
% hObject    handle to startYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function endYear_Callback(hObject, eventdata, handles)
% hObject    handle to endYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endYear as text
%        str2double(get(hObject,'String')) returns contents of endYear as a double


% --- Executes during object creation, after setting all properties.
function endYear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endYear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in populationButton.
function populationButton_Callback(hObject, eventdata, handles)
% hObject    handle to populationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear plot;
population = str2double(get(handles.population, 'String'));
perCapita = str2double(get(handles.perCapita, 'String'));
startYear = str2double(get(handles.startYear, 'String'));
endYear = str2double(get(handles.endYear, 'String'));
growthRate = str2double(get(handles.growthRate, 'String'));
[ xMatrix, populationM, waterDemandM angatCapacityM actualDemandM ] = WaterDemand( population, growthRate, startYear, endYear, perCapita );

handles.endWaterDemand = waterDemandM(end);
%disp(waterDemandM(end));
plotPoints(handles.plotArea, populationM, xMatrix, '-');
legend(handles.plotArea, 'Population', 'Location', 'southeast');



function growthRate_Callback(hObject, eventdata, handles)
% hObject    handle to growthRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in waterDemandButton.
function waterDemandButton_Callback(hObject, eventdata, handles)
% hObject    handle to waterDemandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear plot;
population = str2double(get(handles.population, 'String'));
perCapita = str2double(get(handles.perCapita, 'String'));
startYear = str2double(get(handles.startYear, 'String'));
endYear = str2double(get(handles.endYear, 'String'));
growthRate = str2double(get(handles.growthRate, 'String'));
[ xMatrix, populationM, waterDemandM angatCapacityM actualDemandM industryDemandM] = WaterDemand( population, growthRate, startYear, endYear, perCapita );

plotPoints(handles.plotArea, waterDemandM, xMatrix, '-');
hold(handles.plotArea, 'on');
%disp(actualDemandM);
xMatrix = cell2mat(xMatrix);
newx = xMatrix(1:24, 1:12);
%disp(xMatrix);
plotPoints(handles.plotArea, actualDemandM, newx, 'g-');
hold(handles.plotArea, 'on');
plotPoints(handles.plotArea, industryDemandM, xMatrix, 'v-');
hold(handles.plotArea, 'on');
plotPoints(handles.plotArea, angatCapacityM, xMatrix, 'r--');
hold(handles.plotArea, 'off');
legend(handles.plotArea, 'Water Demand', 'Angat Capacity', 'Location', 'southeast');

[row column] = size(waterDemandM);
% plotBar(handles.barPlotArea, waterDemandM(row,:));
% hold(handles.barPlotArea, 'off');
% plotBar(handles.barPlotArea, angatCapacityM(row, :));

addP = (100 + 175 + 275 + 500 + 500 + 400)*1000000;
% additionalProjects = {};
% for i = 1:12
%     
%     additionalProjects = [additionalProjects addP];
% end
% disp(additionalProjects);
% disp(angatCapacityM(row, :));
% disp(waterDemandM(row, :));
angatCapacityM = cell2mat(angatCapacityM);
waterDemandM = cell2mat(waterDemandM);

initAdjustedDemand = 0 - waterDemandM(1, 1) + angatCapacityM(1, 1);
adjustedDemand = waterDemandM(row, column) - angatCapacityM(row, column) - addP;
barMatrix = [0 0 0;angatCapacityM(row, column) addP adjustedDemand; 0 0 0];
disp(barMatrix);
% demandBars = [waterDemandM(1, 1); waterDemandM(row, column)];
% plotBar(handles.barPlotArea, demandBars);
% hold(handles.barPlotArea, 'on');
plotBar(handles.barPlotArea, barMatrix);
% hold(handles.barPlotArea, 'off');






function plotPoints(plotArea, matrix, xMatrix, pStyle)
if iscell(xMatrix)
    xMatrix = cell2mat(xMatrix);
end
if iscell(matrix)
    matrix = cell2mat(matrix);
end
plot(plotArea, xMatrix(:, 1), matrix(:, 1), pStyle);
set(plotArea,'XMinorTick','on');
grid(plotArea, 'on');

function plotBar(plotArea, matrix)
% matrix = cell2mat(matrix);
bar(plotArea, matrix, 'stacked');



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in waterDemandIndButton.
function waterDemandIndButton_Callback(hObject, eventdata, handles)
% hObject    handle to waterDemandIndButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
