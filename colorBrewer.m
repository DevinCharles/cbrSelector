function varargout = colorBrewer(varargin)
% #colorBrewer
% Matlab ColorBrewer Color Maps (with viewer and selection help).
% 
% # Palette Decision Making 
% colorBrewer() - Shows all available color arrays and thier names
% 
% colorBrewer('type','diverging') - Shows all diverging color arrays and their names (also 'type','d')
% colorBrewer('type',qualitative) - Shows all qualitative color arrays and their names (also 'type','q')
% colorBrewer('type',sequential)  - Shows all sequential color arrays and their names (also, 'type','s')
% 
% colorBrewer('length','twelve') - Shows all color arrays that have 12 colors (also 'length',12 or any number 3-12)
% 
% # Color Map Selection
% Once you know what you want use the 'name' key value pair
% 
% cmap = colorBrewer('name','BrBg') - Returns the BrBg color array as an 8x3 colormap
% cmap = colorBrewer('name','Paired','length',12) - Returns the Paire color array as a 12x3 colormap
% 
% # Setting Current Color Map
% You can now use colormap(cmap) to set the current color map to your new ColorBrewer map
% 
% # Turning Plotting Off
% cmap = colorBrewer('name','Paired','length',12,'plot',false) or 'plot','f' or 'plot','false'
% 
% # Creating the Maps from Scratch
% If you're leery of the cbr.mat file that contains the color maps and want to create them this file on your own. First delete the cbr.mat file then use the command:
% 
% colorBrewer('create')
% 
% This will recreate the cbr.mat file from the text in the file cbr_cell.m. Additionally, you can use this to add extra color pallets. 
%
%     Copyright (C) 2015  Devin C Prescott
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%     
%     Author:
%     Devin C Prescott
%     devin.c.prescott@gmail.com

    try
        load('cbr.mat')
    catch
        CBR = create_cbr();
    end

    % Set Defaults
    ind = true(length(CBR),1);
    len = 'default';
    type = 'default';
    plot_bool = false;

    nums = {'one','two','three','four','five','six','seven','eight','nine',...
            'ten','eleven','twelve'};

    if isempty(varargin) || any(strcmpi(varargin{1},{'help','-h','-?'}))
        disp('Name-Value Pairs:')
        disp('    type: diverging,qualitative,sequential')
        disp('    length: one,two,three,...twelve')
        disp('    name: YlGn,YlGnBu,GnBu,...Blues,Greens,...Accent...')
        disp('    plot: true,false')
        disp('')
        
        plot_cbr(ind,'eight',CBR)
        varargout{1} = [];
        return
    end
    
    if mod(length(varargin),2) ~= 0
        disp('Inputs should be name,value pairs, try "help"')
        return
    end

    for pair = 1:length(varargin)/2
        key = varargin{2*pair-1};
        value = varargin{2*pair};

        switch key
            case 'create'
                CBR = create_cbr();
                
            case 'plot'
                if islogical(value)
                    plot_bool = value;
                elseif strcmpi(value,{'true','t'})
                    plot_bool = true;
                elseif strcmpi(value,{'false','f'})
                    plot_bool = false;
                else
                    disp ('Did you mean ''plot'',true ?')
                    plot_bool = false;
                end
                
            case {'length','len'}
                if ~ischar(value)
                    len = nums{value};
                else
                    len = value;
                end
                
                if any(strcmpi(len,{'one','two'}))
                    len = 'three';
                end
                
            case 'name'
                ind = strcmpi({CBR.name}',value);
            case 'type'
                if any(strcmpi(value,{'diverging','div','d'}))
                    ind = strcmpi({CBR.type}','diverging');
%                     disp({CBR(ind).name}')
                    type = 'diverging';
                elseif any(strcmpi(value,{'qualitative','qual','q'}))
                    ind = strcmpi({CBR.type}','qualitative');
%                     disp({CBR(ind).name}')
                    type = 'qualitative';
                elseif any(strcmpi(value,{'sequential','seq','s'}))
                    ind = strcmpi({CBR.type}','sequential');
%                     disp({CBR(ind).name}')
                    type = 'sequential';
                else
                    ind = true(length(CBR),1);
                end  
        end
    end
    
    if strcmpi(len,'default')
        len = 'eight';
        plot_bool = true;
    end
    
    if strcmpi(type,'default')
        plot_bool = true;
    end
    
    % Restructure with only those that have requested length
    ind2 = logical(cell2mat(cellfun(@isempty,{CBR.(len)},...
    'UniformOutput',false)))';
    ind = ind&~ind2;
    
    if plot_bool
        plot_cbr(ind,len,CBR);
    end
    
    try 
        varargout{1} = {CBR(ind).(len)};
    catch
        varargout = {};
    end
    
end

function CBR = create_cbr()
        run('cbr_cell.m');
        nums = {'one','two','three','four','five','six','seven','eight','nine',...
            'ten','eleven','twelve'};
        div = {'spectral','rdylgn','rdylbu','rdgy',...
            'rdbu','puor','prgn','piyg','brbg'};
        qual = {'set3','set2','set1','pastel2','pastel1','paired','dark2','accent'};
        CBR = struct;
        for color = 1:length(cbr)
            for pair = 1:length(cbr{color})/2
                field = cbr{color}{2*pair-1};
                value = cbr{color}{2*pair};
                if strcmpi(field,'name')
                    if any(strcmpi(value,div))
                        CBR(color).('type')='diverging';
                    elseif any(strcmpi(value,qual))
                        CBR(color).('type')='qualitative';
                    else
                        CBR(color).('type')='sequential';
                    end
                end
                if ~ischar(field)
                    value = hex2rgb(value);
                    field = nums{field};
                end
                CBR(color).(field)=value;
            end
        end
        clearvars cbr
        save('cbr.mat','CBR')
end

function plot_cbr(ind,len,CBR)    
    [m,n] = size([CBR(ind).(len)]);
    n = n/3;
    if n < 1 || m < 1
        fprintf('\nCouldn''t find an array of length %s and type ''%s''.\n',...
            len,type);
        disp('Try reducing the size of the array required.');
        return
    end
    [x,y] = meshgrid(1:n+1,1:m+1);
    z = ones(size(x));
    len_array = reshape([CBR(ind).(len)],m,3,n);
    red = reshape(len_array(:,1,:),m,n);
    grn = reshape(len_array(:,2,:),m,n);
    blu = reshape(len_array(:,3,:),m,n);
    A = reshape([red,grn,blu],m,n,3)./255;
    
    fig = figure;
    screen = get(0,'ScreenSize');
    sw = screen(3); sh = screen(4);
    nb = min([35,round((sh-150)/n)]);
    
    set(fig,'Position',[sw-nb*m-50,sh-nb*n-75,nb*m,nb*n],...
        'Resize','off',...
        'MenuBar','none',...
        'ToolBar','none',...
        'NumberTitle','off',...
        'Name','ColorBrewer')

    pv = [0,0,1,1];
    subplot('Position',pv)
    s = surf(x,y,z,A);
    view(90,90);
    set(gca,'XLim',[1,n+1],'YLim',[1,m+1],...
        'ytick',1.5:1:(m+0.5),'xtick',1.5:1:(n+0.5))
    names = {CBR(ind).name}';
%     set(gca,'xticklabel',names)
%     set(gca,'yticklabel',1:m)
    set(s,'EdgeColor','none')
    x = repmat([1:n+1],2,1)';
    y = repmat([1,m+1],n+1,1);
    z = 2.*ones(n+1,2);
    hold on 
    plot3(x',y',z','-k','LineWidth',2)
    plot3([1,n+1;1,n+1]',[1,1;m+1,m+1]',[2,2;2,2],'-k','LineWidth',2)
    
    x = x(1:end-1,1)+0.5;
    y = 0.5+ones(length(x),1);
    z = z(1:end-1,1)+1;
    text(x',y',z',names,'FontSize',13);
    hold off
end
    