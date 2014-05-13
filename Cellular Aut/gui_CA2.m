function varargout = gui_CA2(varargin)
% GUI_CA2 MATLAB code for gui_CA2.fig
%      GUI_CA2, by itself, creates a new GUI_CA2 or raises the existing
%      singleton*.
%
%      H = GUI_CA2 returns the handle to a new GUI_CA2 or the handle to
%      the existing singleton*.
%
%      GUI_CA2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CA2.M with the given input arguments.
%
%      GUI_CA2('Property','Value',...) creates a new GUI_CA2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_CA2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_CA2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_CA2

% Last Modified by GUIDE v2.5 13-May-2014 11:49:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_CA2_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_CA2_OutputFcn, ...
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


% --- Executes just before gui_CA2 is made visible.
function gui_CA2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_CA2 (see VARARGIN)

% Set the various panels to be off or on
set(handles.uipanel5,'Visible','off')


handles.c_T = 100;
handles.c_simulation = 1;
handles.c_size = 200;
handles.c_width_full = handles.c_size;
handles.c_depth_full = handles.c_size;
handles.c_width_e = handles.c_width_full;
handles.c_width_m = handles.c_width_full;
handles.c_depth_e = 1;
handles.c_separation = 0;
handles.c_depth_m = handles.c_size;
handles.c_epithelium_density = 1; 
handles.c_mesenchyme_density = 0.1;
handles.c_depth_mesenstart = 1;
handles.c_width_mesenstart = 1;




handles.ck_dg = 100;
handles.ck_gamma = 1;
handles.ckp_moveprob = 0.5; % Probability of move vs proliferate. 1 means always move. 0 always proliferate
handles.ck_neighbours = 4; % Choose the number of nearest neighbours for movement/proliferation: 4 or 8
handles.ck_movement_rule = 1; % Choose a particular rule for allowed moves. 1 is allow all possible moves into vacant spots only; 2 is don't allow movements into cells which
% are unconnected only for the active cell in question; 3 doesn't allow
% moves which create any cells which are unconnected (so not just for the
% active cell); 4 allows movement into either a vacant space or a
% mesenchyme spot; 5 is the same as 2 but allows for movement into
% mesenchyme; 6 allows all moves and allows the movement into the
% mesenchyme iff there are available spots for the mesenchyme cell
handles.ck_moveprob_rule = 1; % Select the type of rule to use for P(move). 1 for a constant probability of move. 2 for a rule in which the probability of a move increases
% if the concentration of GDNF is higher. 3 is for when the probability of
% a movement is dependent on the sum of all positive local GDNF gradients
handles.ck_moveprob_cons = 1; % The constant used in rule 1 for P(move)
handles.ck_move_norm_cons = -150; % The constant to be used in the argument of the norm cdf function used in rule 2/3
handles.ck_move_norm_slope = 50; % The constant to be used to multiply the local GDNF concentration by in the argument to the normal cdf in rule 2/3
handles.ck_moving_rule = 1; % Select the type of move for probabilistically choosing between the available moves 
handles.c_pmove_grad = 10; %The coefficients used in targeting cells
% handles.c_target_cons = 0; % Another constant used in targeting cells
handles.ck_prolifprob_rule = handles.ck_moveprob_rule; % Select the type of rule to use for P(prolif). 1 for a constant probability of move. 2 for a rule in which the probability of a move increases
% if the concentration of GDNF is higher. 3 is for when the probability of
% a movement is dependent on the sum of all positive local GDNF gradients
handles.ck_prolif_choosecell_rule = handles.ck_moving_rule; % Select the type of move for probabilistically choosing between the available moves 

handles.v_parameters = [handles.ck_dg;handles.ck_gamma; handles.ckp_moveprob; handles.ck_neighbours;handles.ck_movement_rule;handles.c_depth_full;handles.c_width_full;handles.ck_moveprob_rule;handles.ck_moveprob_cons;handles.ck_move_norm_cons;handles.ck_move_norm_slope;handles.ck_moving_rule;handles.c_pmove_grad;handles.ck_prolifprob_rule;handles.ck_prolif_choosecell_rule];


% Set the slider values and print off rounded numbers
set(handles.slider1,'Value',handles.ck_dg);
set(handles.slider2,'Value',handles.ck_gamma);
set(handles.slider3,'Value',handles.c_mesenchyme_density);
set(handles.slider7,'Value',handles.ckp_moveprob);
set(handles.slider8,'Value',handles.ck_moveprob_cons);
set(handles.slider16,'Value',handles.ck_move_norm_cons);
set(handles.slider19,'Value',handles.ck_move_norm_slope);
set(handles.slider20,'Value',handles.c_pmove_grad);

if handles.ck_neighbours == 4
    set(handles.popupmenu4,'Value',1);
else
    set(handles.popupmenu4,'Value',2);
end
    
set(handles.popupmenu5,'Value',handles.ck_movement_rule);
set(handles.popupmenu6,'Value',handles.ck_moveprob_rule);
set(handles.popupmenu7,'Value',handles.ck_moving_rule);


c_dg_rounded = num2str(handles.ck_dg);
c_gamma_rounded = num2str(handles.ck_gamma);
c_mes_rounded = num2str(100*handles.c_mesenchyme_density);
c_dg_num = findstr('.',c_dg_rounded);
c_gamma_num = findstr('.',c_gamma_rounded);
c_mes_num = findstr('.',c_mes_rounded);
if length(c_dg_num) > 0
    c_dg_rounded=c_dg_rounded(1:c_dg_num-1)
    set(handles.text3,'String',c_dg_rounded);
else
    set(handles.text3,'String',handles.ck_dg);
end
if length(c_gamma_num) > 0
    c_gamma_rounded = c_gamma_rounded(1:c_gamma_num-1);
    set(handles.text4,'String',c_gamma_rounded);
else
    set(handles.text4,'String',handles.ck_gamma);
end
if length(c_mes_num) > 0
    c_mes_rounded = c_mes_rounded(1:c_mes_num-1);
    c_mes_rounded = strcat(c_mes_rounded,'%');
    set(handles.text6,'String',c_mes_rounded);
else
    a = strcat(num2str(c_mes_rounded),'%')
    set(handles.text6,'String',a);
end
set(handles.text11,'String','0');

handles.c0 = handles.ck_moveprob_cons;
handles.c1 = handles.ck_move_norm_cons;
handles.c2 = handles.ck_move_norm_slope;
handles.c3 = handles.c_pmove_grad;
set(handles.text47,'String',num2str(handles.c0));
set(handles.text61,'String',num2str(handles.c1));
set(handles.text67,'String',num2str(handles.c2));
set(handles.text70,'String',num2str(handles.c3));

% Choose default command line output for gui_CA2
handles.output = hObject;

% Initially choose image
handles.graph_selector = 0;
handles.diagnostics = 0;

% Update handles structure
guidata(hObject, handles);


f_simulation_selector_void(hObject,handles);










% UIWAIT makes gui_CA2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_CA2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function [] = f_invitro_plotter_void(hObject,handles)
% A function which allows user to input parameters and plots the result


% Diagnostic box visualisation
set(handles.text26,'String',handles.v_parameters(1));
set(handles.text27,'String',handles.v_parameters(2));
set(handles.text28,'String',handles.v_parameters(3));
set(handles.text29,'String',handles.v_parameters(4));
set(handles.text30,'String',handles.v_parameters(5));
set(handles.text31,'String',handles.v_parameters(6));
set(handles.text32,'String',handles.v_parameters(7));
set(handles.text33,'String',handles.v_parameters(8));
set(handles.text34,'String',handles.v_parameters(9));
set(handles.text35,'String',handles.v_parameters(10));
set(handles.text36,'String',handles.v_parameters(11));
set(handles.text37,'String',handles.v_parameters(12));
set(handles.text38,'String',handles.v_parameters(13));
set(handles.text39,'String',handles.v_parameters(14));
set(handles.text40,'String',handles.v_parameters(15));


%
%% Parameters
% Specify the number of time cycles to iterate through
% c_T = 100;

% Specify the parameters for the area
% c_size = 200; 


% Update and round parameters to print them off
guidata(hObject, handles);
c_dg_rounded = num2str(handles.v_parameters(1));
c_gamma_rounded = num2str(handles.v_parameters(2));
c_mes_rounded = num2str(100*handles.c_mesenchyme_density);
c_dg_num = findstr('.',c_dg_rounded);
c_gamma_num = findstr('.',c_gamma_rounded);
c_mes_num = findstr('.',c_mes_rounded);
if length(c_dg_num) > 0
    c_dg_rounded=c_dg_rounded(1:c_dg_num-1)
    set(handles.text3,'String',c_dg_rounded);
else
    set(handles.text3,'String',handles.v_parameters(1));
end
if length(c_gamma_num) > 0
    c_gamma_rounded = c_gamma_rounded(1:c_gamma_num-1);
    set(handles.text4,'String',c_gamma_rounded);
else
    set(handles.text4,'String',handles.v_parameters(2));
end
if length(c_mes_num) > 0
    c_mes_rounded = c_mes_rounded(1:c_mes_num-1);
    c_mes_rounded = strcat(c_mes_rounded,'%');
    set(handles.text6,'String',c_mes_rounded);
else
    a = strcat(num2str(c_mes_rounded),'%');
    set(handles.text6,'String',a);
end
set(handles.text6,'String',handles.c_mesenchyme_density);
set(handles.text25,'String',num2str(handles.v_parameters(4)));
set(handles.text23,'String',handles.v_parameters(3));


handles.c0 = handles.ck_moveprob_cons;
handles.c1 = handles.ck_move_norm_cons;
handles.c2 = handles.ck_move_norm_slope;
handles.c3 = handles.c_pmove_grad;
set(handles.text47,'String',num2str(handles.c0));
set(handles.text61,'String',num2str(handles.c1));
set(handles.text67,'String',num2str(handles.c2));
set(handles.text70,'String',num2str(handles.c3));

guidata(hObject, handles);


handles.c_depth_e = 1;
handles.c_separation = 0;
handles.c_depth_m = handles.c_size;
handles.c_depth_mesenstart = 1;
handles.v_parameters = [handles.ck_dg;handles.ck_gamma; handles.ckp_moveprob; handles.ck_neighbours;handles.ck_movement_rule;handles.c_depth_full;handles.c_width_full;handles.ck_moveprob_rule;handles.ck_moveprob_cons;handles.ck_move_norm_cons;handles.ck_move_norm_slope;handles.ck_moving_rule;handles.c_pmove_grad;handles.ck_prolifprob_rule;handles.ck_prolif_choosecell_rule];



%% Initial area of epithelium and mesenchyme created, and the initial field of GDNF calculated
% Create the epithelium layer, and the mesenchyme
m_cell = f_create_area_m(handles.c_width_full, handles.c_depth_full);
m_cell = f_create_random_epithelium_m(m_cell, handles.c_depth_full/2,handles.c_width_full/2, 500,handles.v_parameters);
m_cell = f_create_mesenchyme_m(m_cell, handles.c_width_m, handles.c_depth_m, handles.c_mesenchyme_density, handles.c_depth_mesenstart,handles.c_width_mesenstart);


% Create the initial field of GDNF according to the distribution of the
% mesenchyme and epithelium
m_GDNF = f_field_update_m(m_cell,handles.v_parameters);


%% Run the simulation through the T time steps
% Iterate through updating the m_cell and m_GDNF arrays at each time step
c_mesen_tot = sum(sum(m_cell==-1));

% Stop button!
handles = guidata(hObject);
handles.test1 = 0;

% Graph selector
if handles.graph_selector == 0;
    set(handles.text7,'String','Cell distribution');
    set(handles.text9,'String','GDNF distribution');
else
    set(handles.text7,'String','Cell numbers');
    set(handles.text9,'String','Acceptance probability');
end


guidata(hObject, handles);

% Create the acceptance and epithelium number vectors
v_acceptance = zeros(1,1);
v_epithelium = zeros(1,1);

global kk 
kk = 0;

% Go through the time steps 
for t = 1:handles.c_T
    
    
    
    % Update handles structure globally each iteration
    handles = guidata(hObject);
    
    set(handles.text11,'String',num2str(t));
    if handles.test1 == 0
        
        c_mesen_running = sum(sum(m_cell==-1));
        if c_mesen_running ~=c_mesen_tot
            'A mesenchyme has gone missing (f_lifecyle_iterator_ms)'
        end

        % Update the cells and get the number of accepted epithelium
        % transitions
        
        [m_cell,c_move] = f_update_cells_m(m_cell,m_GDNF,handles.v_parameters);
        
        % Update GDNF field
        m_GDNF = f_field_update_m(m_cell,handles.v_parameters);
        
        handles.m_cell = m_cell;
        handles.m_GDNF = m_GDNF;
        
        % Get the total number of epithelium cells
        c_epithelium = sum(sum(m_cell==1));
        
        % Now put it as a % of size of total region
        c_total = handles.c_depth_full*handles.c_width_full;
        c_epithelium_per = 100*c_epithelium/c_total;
        v_epithelium(t) = c_epithelium_per;
        
        % Work out the acceptance rate
        c_acceptance = 100*c_move/c_epithelium;
        v_acceptance(t) = c_acceptance;
        
        if handles.graph_selector == 0
            axes(handles.axes1)
            imagesc(m_cell)

            

            axes(handles.axes2)
            imagesc(m_GDNF)
            hold on
            c=contour(m_GDNF);
            clabel(c)
            hold off
            pause(0.01)
            
        else
            
            axes(handles.axes1)
            plot(1:t,v_epithelium,'LineWidth',4)
            xlim([1 handles.c_T])
            ylim([0 25])

            handles.m_cell = m_cell;
            handles.m_GDNF = m_GDNF;
            
            axes(handles.axes2)
            plot(1:t,v_acceptance,'LineWidth',4)
            xlim([1 handles.c_T])
            ylim([0 60])
            pause(0.01)
        end

        
    else
        while handles.test1 == 1
            % Update handles structure globally each iteration
            handles = guidata(hObject);
            pause(0.01)
        end

    end
    
end


function [] = f_invivo_plotter_void(hObject,handles)
% A function which allows user to input parameters and plots the result


% Diagnostic box visualisation
set(handles.text26,'String',handles.v_parameters(1));
set(handles.text27,'String',handles.v_parameters(2));
set(handles.text28,'String',handles.v_parameters(3));
set(handles.text29,'String',handles.v_parameters(4));
set(handles.text30,'String',handles.v_parameters(5));
set(handles.text31,'String',handles.v_parameters(6));
set(handles.text32,'String',handles.v_parameters(7));
set(handles.text33,'String',handles.v_parameters(8));
set(handles.text34,'String',handles.v_parameters(9));
set(handles.text35,'String',handles.v_parameters(10));
set(handles.text36,'String',handles.v_parameters(11));
set(handles.text37,'String',handles.v_parameters(12));
set(handles.text38,'String',handles.v_parameters(13));
set(handles.text39,'String',handles.v_parameters(14));
set(handles.text40,'String',handles.v_parameters(15));



% Update and round parameters to print them off
guidata(hObject, handles);
c_dg_rounded = num2str(handles.v_parameters(1));
c_gamma_rounded = num2str(handles.v_parameters(2));
c_mes_rounded = num2str(100*handles.c_mesenchyme_density);
c_dg_num = findstr('.',c_dg_rounded);
c_gamma_num = findstr('.',c_gamma_rounded);
c_mes_num = findstr('.',c_mes_rounded);
if length(c_dg_num) > 0
    c_dg_rounded=c_dg_rounded(1:c_dg_num-1)
    set(handles.text3,'String',c_dg_rounded);
else
    set(handles.text3,'String',handles.v_parameters(1));
end
if length(c_gamma_num) > 0
    c_gamma_rounded = c_gamma_rounded(1:c_gamma_num-1);
    set(handles.text4,'String',c_gamma_rounded);
else
    set(handles.text4,'String',handles.v_parameters(2));
end
if length(c_mes_num) > 0
    c_mes_rounded = c_mes_rounded(1:c_mes_num-1);
    c_mes_rounded = strcat(c_mes_rounded,'%');
    set(handles.text6,'String',c_mes_rounded);
else
    a = strcat(num2str(c_mes_rounded),'%');
    set(handles.text6,'String',a);
end
set(handles.text23,'String',handles.v_parameters(3));

% Graph selector
if handles.graph_selector == 0;
    set(handles.text7,'String','Cell distribution');
    set(handles.text9,'String','GDNF distribution');
else
    set(handles.text7,'String','Cell numbers');
    set(handles.text9,'String','Acceptance probability');
end

handles.c0 = handles.ck_moveprob_cons;
handles.c1 = handles.ck_move_norm_cons;
handles.c2 = handles.ck_move_norm_slope;
handles.c3 = handles.c_pmove_grad;
set(handles.text47,'String',num2str(handles.c0));
set(handles.text61,'String',num2str(handles.c1));
set(handles.text67,'String',num2str(handles.c2));
set(handles.text70,'String',num2str(handles.c3));




% Specify the parameters for the area
handles.c_depth_e = 20;
handles.c_separation = 10;
handles.c_depth_m = 30;
handles.c_depth_mesenstart = handles.c_depth_e+handles.c_separation;
handles.v_parameters = [handles.ck_dg;handles.ck_gamma; handles.ckp_moveprob; handles.ck_neighbours;handles.ck_movement_rule;handles.c_depth_full;handles.c_width_full;handles.ck_moveprob_rule;handles.ck_moveprob_cons;handles.ck_move_norm_cons;handles.ck_move_norm_slope;handles.ck_moving_rule;handles.c_pmove_grad;handles.ck_prolifprob_rule;handles.ck_prolif_choosecell_rule];


%% Initial area of epithelium and mesenchyme created, and the initial field of GDNF calculated
% Create the epithelium layer, and the mesenchyme
m_cell = f_create_area_m(handles.c_width_full, handles.c_depth_full);
m_cell = f_create_epithelium_m(m_cell, handles.c_width_e, handles.c_depth_e, handles.c_epithelium_density);
m_cell = f_create_mesenchyme_m(m_cell, handles.c_width_m, handles.c_depth_m, handles.c_mesenchyme_density, handles.c_depth_mesenstart,handles.c_width_mesenstart);


% Create the initial field of GDNF according to the distribution of the
% mesenchyme and epithelium
m_GDNF = f_field_update_m(m_cell,handles.v_parameters);


%% Run the simulation through the T time steps
% Iterate through updating the m_cell and m_GDNF arrays at each time step
c_mesen_tot = sum(sum(m_cell==-1));

% Stop button!
handles = guidata(hObject);
handles.test1 = 0;


guidata(hObject, handles);



% Go through the time steps 
for t = 1:handles.c_T
    set(handles.text11,'String',num2str(t));
    % Update handles structure globally each iteration
    handles = guidata(hObject);
    
    
    if handles.test1 == 0
        c_mesen_running = sum(sum(m_cell==-1));
        if c_mesen_running ~=c_mesen_tot
            'A mesenchyme has gone missing (f_lifecyle_iterator_ms)'
        end

        [m_cell,c_move] = f_update_cells_m(m_cell,m_GDNF,handles.v_parameters);
        m_GDNF = f_field_update_m(m_cell,handles.v_parameters);
        
        % Get the total number of epithelium cells
        c_epithelium = sum(sum(m_cell==1));
        
        % Now put it as a % of size of total region
        c_total = handles.c_depth_full*handles.c_width_full;
        c_epithelium_per = 100*c_epithelium/c_total;
        v_epithelium(t) = c_epithelium_per;
        
        % Work out the acceptance rate
        c_acceptance = 100*c_move/c_epithelium;
        v_acceptance(t) = c_acceptance;
        
        if handles.graph_selector == 0
            axes(handles.axes1)
            imagesc(m_cell)

            

            axes(handles.axes2)
            imagesc(m_GDNF)
            hold on
            c=contour(m_GDNF);
            clabel(c)
            hold off
            pause(0.01)
            
        else
            
            axes(handles.axes1)
            plot(1:t,v_epithelium,'LineWidth',4)
            xlim([1 handles.c_T])
            ylim([0 25])

            handles.m_cell = m_cell;
            handles.m_GDNF = m_GDNF;
            
            axes(handles.axes2)
            plot(1:t,v_acceptance,'LineWidth',4)
            xlim([1 handles.c_T])
            ylim([0 60])
            pause(0.01)
        end
        
        
    else
            while handles.test1 == 1
                    % Update handles structure globally each iteration
                handles = guidata(hObject);
                pause(0.01)
            end
    end
    
    
end


function [] = f_simulation_selector_void(hObject,handles)
% A function which plots either the in vitro or in vivo simulation
% dependent on the handles

f_parameters_visible(hObject,handles);


switch handles.c_simulation
    case 1
        f_invitro_plotter_void(hObject,handles)
    case 2
        f_invivo_plotter_void(hObject,handles)
end





% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

handles.c_simulation = get(hObject,'Value');
switch handles.c_simulation
    case 1
        f_invitro_plotter_void(hObject,handles)
    case 2
        f_invivo_plotter_void(hObject,handles)
end

% Update handles structure
guidata(hObject, handles);


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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Get the diffusion coefficient

handles.ck_dg = get(hObject,'Value');
a = handles.ck_dg;

handles.v_parameters(1) = a;

% Update handles structure
guidata(hObject, handles);


f_simulation_selector_void(hObject,handles);




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ck_gamma = get(hObject,'Value');
handles.v_parameters(2) = handles.ck_gamma;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);





% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.c_mesenchyme_density = get(hObject,'Value');


% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update handles structure
guidata(hObject, handles)
f_stopper_void(hObject,handles);

function f_stopper_void(hObject,handles)
% A function which plots and stops
% get(handles.pushbutton2)
% get(handles.pushbutton2,'Value')
handles = guidata(hObject);
handles.test1 = mod(handles.test1 + 1,2); % Let it alternate between 0 and 1
guidata(hObject,handles);


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

c_neighbours = get(hObject,'Value');
switch c_neighbours
    case 1
        handles.ck_neighbours = 4;
    case 2
        handles.ck_neighbours = 8;
end

handles.v_parameters(4) = handles.ck_neighbours;

% Update handles structure
guidata(hObject, handles);



f_simulation_selector_void(hObject,handles);






% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5

c_movement_rule = get(hObject,'Value');
switch c_movement_rule
    case 1
        handles.ck_movement_rule  = 1;
    case 2
        handles.ck_movement_rule  = 2;
    case 3
        handles.ck_movement_rule  = 3;
    case 4
        handles.ck_movement_rule  = 4;
    case 5
        handles.ck_movement_rule  = 5;
    case 6
        handles.ck_movement_rule  = 6;
end

handles.v_parameters(5) = handles.ck_movement_rule;

% Update handles structure
guidata(hObject, handles);

f_simulation_selector_void(hObject,handles);





% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ckp_moveprob = get(hObject,'Value');
handles.v_parameters(3) = handles.ckp_moveprob;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);




% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


c_moveprob = get(hObject,'Value');
switch c_moveprob
    case 1
        handles.ck_moveprob_rule  = 1;
    case 2
        handles.ck_moveprob_rule  = 2;
    case 3
        handles.ck_moveprob_rule  = 3;
end

handles.v_parameters(8) = handles.ck_moveprob_rule;

% Update handles structure
guidata(hObject, handles);

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update handles structure
guidata(hObject, handles)
f_graphselector_void(hObject,handles);

function f_graphselector_void(hObject,handles)
% A function which chooses the type of plot to show
% get(handles.pushbutton2)
% get(handles.pushbutton2,'Value')
handles = guidata(hObject);
handles.graph_selector = mod(handles.graph_selector + 1,2); % Let it alternate between 0 and 1

if handles.graph_selector == 0
    set(handles.text7,'String','Cell distribution');
    set(handles.text9,'String','GDNF distribution');
else
    set(handles.text7,'String','Cell numbers');
    set(handles.text9,'String','Acceptance rate');
end


guidata(hObject,handles);


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7

c_temp = get(hObject,'Value');
switch c_temp
    case 1
        handles.ck_moving_rule  = 1;
    case 2
        handles.ck_moving_rule  = 2;
    case 3
        handles.ck_moving_rule  = 3;
    case 4
        handles.ck_moving_rule  = 4;
    case 5
        handles.ck_moving_rule  = 5;
    case 6
        handles.ck_moving_rule  = 6;
    case 7
        handles.ck_moving_rule  = 7;
        
end

handles.v_parameters(12) = handles.ck_moving_rule;


% Update handles structure
guidata(hObject, handles);

f_simulation_selector_void(hObject,handles);



% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8

c_moveprob = get(hObject,'Value');
switch c_moveprob
    case 1
        handles.ck_prolifprob_rule  = 1;
    case 2
        handles.ck_prolifprob_rule  = 2;
    case 3
        handles.ck_prolifprob_rule  = 3;
end

handles.v_parameters(14) = handles.ck_prolifprob_rule;

% Update handles structure
guidata(hObject, handles);

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9
c_temp = get(hObject,'Value');
switch c_temp
    case 1
        handles.ck_prolif_choosecell_rule  = 1;
    case 2
        handles.ck_prolif_choosecell_rule  = 2;
    case 3
        handles.ck_prolif_choosecell_rule  = 3;
    case 4
        handles.ck_prolif_choosecell_rule  = 4;
    case 5
        handles.ck_prolif_choosecell_rule  = 5;
    case 6
        handles.ck_prolif_choosecell_rule  = 6;
    case 7
        handles.ck_prolif_choosecell_rule  = 7;
end

handles.v_parameters(15) = handles.ck_prolif_choosecell_rule;

% Update handles structure
guidata(hObject, handles);

f_simulation_selector_void(hObject,handles);



% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ck_moveprob_cons = get(hObject,'Value');
handles.v_parameters(9) = handles.ck_moveprob_cons;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);



% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function f_parameters_visible(hObject,handles)
    if or(handles.ck_moveprob_rule==1, handles.ck_prolifprob_rule==1)
        set(handles.slider8,'Visible','on')
        set(handles.text45,'Visible','on')
        set(handles.text72,'Visible','on')
        set(handles.text47,'Visible','on')
    else
        set(handles.slider8,'Visible','off')
        set(handles.text45,'Visible','off')
        set(handles.text72,'Visible','off')
        set(handles.text47,'Visible','off')
    end


    if or(handles.ck_moveprob_rule~=1, handles.ck_prolifprob_rule~=1)
        set(handles.text60,'Visible','on')
        set(handles.text66,'Visible','on')
        set(handles.text61,'Visible','on')
        set(handles.text67,'Visible','on')
        set(handles.text68,'Visible','on')
        set(handles.slider16,'Visible','on')
        set(handles.slider19,'Visible','on')
    else
        set(handles.text60,'Visible','off')
        set(handles.text66,'Visible','off')
        set(handles.text61,'Visible','off')
        set(handles.text67,'Visible','off')
        set(handles.text68,'Visible','off')
        set(handles.slider16,'Visible','off')
        set(handles.slider19,'Visible','off')
    end
    
    if or(handles.ck_moving_rule~=1,handles.ck_prolif_choosecell_rule~=1)
        set(handles.text69,'Visible','on')
        set(handles.text70,'Visible','on')
        set(handles.text71,'Visible','on')
        set(handles.slider20,'Visible','on')
    else
        set(handles.text69,'Visible','off')
        set(handles.text70,'Visible','off')
        set(handles.text71,'Visible','off')
        set(handles.slider20,'Visible','off')
    end




% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.ck_move_norm_cons = get(hObject,'Value');
handles.v_parameters(10) = handles.ck_move_norm_cons;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


handles.ck_move_norm_slope = get(hObject,'Value');
handles.v_parameters(11) = handles.ck_move_norm_slope;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.c_pmove_grad = get(hObject,'Value');
handles.v_parameters(13) = handles.c_pmove_grad;

% Update handles structure
guidata(hObject, handles)

f_simulation_selector_void(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.diagnostics = mod(handles.diagnostics + 1,2);
if handles.diagnostics == 0
    set(handles.uipanel4,'Visible','on')
    set(handles.uipanel5,'Visible','off')
else
    set(handles.uipanel4,'Visible','off')
    set(handles.uipanel5,'Visible','on')
end

% Update handles structure
guidata(hObject, handles)