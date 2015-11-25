# colorBrewer
Matlab ColorBrewer Color Maps (with viewer and selection help).

# Palette Decision Making 
colorBrewer() - Shows all available color arrays and thier names

colorBrewer('type','diverging') - Shows all diverging color arrays and their names (also 'type','d')
colorBrewer('type',qualitative) - Shows all qualitative color arrays and their names (also 'type','q')
colorBrewer('type',sequential)  - Shows all sequential color arrays and their names (also, 'type','s')

colorBrewer('length','twelve') - Shows all color arrays that have 12 colors (also 'length',12 or any number 3-12)

# Color Map Selection
Once you know what you want use the 'name' key value pair

cmap = colorBrewer('name','BrBg') - Returns the BrBg color array as an 8x3 colormap
cmap = colorBrewer('name','Paired','length',12) - Returns the Paire color array as a 12x3 colormap

# Setting Current Color Map
You can now use colormap(cmap) to set the current color map to your new ColorBrewer map

# Turning Plotting Off
cmap = colorBrewer('name','Paired','length',12,'plot',false) or 'plot','f' or 'plot','false'

# Creating the Maps from Scratch
If you're leery of the cbr.mat file that contains the color maps and want to create them this file on your own. First delete the cbr.mat file then use the command:

colorBrewer('create')

This will recreate the cbr.mat file from the text in the file cbr_cell.m. Additionally, you can use this to add extra color pallets. 
