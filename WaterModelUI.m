function varargout = WaterModelUI(varargin)
% WATERMODELUI MATLAB code for WaterModelUI.fig
%      WATERMODELUI, by itself, creates a new WATERMODELUI or raises the existing
%      singleton*.
%
%      H = WATERMODELUI returns the handle to a new WATERMODELUI or the handle to
%      the existing singleton*.
%
%      WATERMODELUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WATERMODELUI.M with the given input arguments.
%
%      WATERMODELUI('Property','Value',...) creates a new WATERMODELUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WaterModelUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WaterModelUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WaterModelUI

% Last Modified by GUIDE v2.5 25-Apr-2016 00:37:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WaterModelUI_OpeningFcn, ...
                   'gui_OutputFcn',  @WaterModelUI_OutputFcn, ...
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


% --- Executes just before WaterModelUI is made visible.
function WaterModelUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WaterModelUI (see VARARGIN)

% Choose default command line output for WaterModelUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WaterModelUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WaterModelUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[angatDam ipoDam lamesaDam xMatrix] = WaterModel ();

disp(xMatrix);
% disp('angat water');
%disp(angatDam);
plotPoints(handles.angatWater, angatDam(:, :, 1), xMatrix, size(xMatrix));
% disp('angatTransfer');
labels = {};
hStart = 1990;
hEnd = 2012;
for i = hStart:hEnd
    labels = [labels num2str(i)];
end
legend(handles.angatWater, labels, 'Location', 'northwest');
% disp(angatDam(2));
% disp('angatOverflow');

plotPoints(handles.ipoWater, ipoDam(:, :, 1), xMatrix, size(xMatrix));
legend(handles.ipoWater, labels, 'Location', 'northwest');
plotPoints(handles.lamesaWater, lamesaDam(:, :, 1), xMatrix, size(xMatrix));
legend(handles.lamesaWater, labels, 'Location', 'northwest');
% disp(angatDam(3));
% disp('ipo');
% disp(ipoDam);
% disp('lamesa');
% disp(lamesaDam);


function plotPoints(plotArea, matrix, xMatrix, years)
xMatrix = cell2mat(xMatrix);
matrix = cell2mat(matrix);
plot(plotArea, xMatrix(:, :), matrix(:, :));
set(plotArea, 'XMinorTick', 'on');
grid(plotArea, 'on');
