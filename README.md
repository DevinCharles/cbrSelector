# cbrSelector
Matlab Color Maps (with viewer and selection help).

# Credit
Colors from www.colorbrewer.org by Cynthia A. Brewer, Geography, Pennsylvania State University
This product includes color specifications and designs developed by Cynthia Brewer (http://colorbrewer.org/)

The create portion of this requires hex2rgb by Jos (http://www.mathworks.com/matlabcentral/fileexchange/45727-hex2rgb)
which is only required if you need to recreate the cbr.mat file.

# Palette Decision Making 
cbrSelector() - Shows all available color arrays and thier names

cbrSelector('type','diverging') - Shows all diverging color arrays and their names (also 'type','d')
cbrSelector('type',qualitative) - Shows all qualitative color arrays and their names (also 'type','q')
cbrSelector('type',sequential)  - Shows all sequential color arrays and their names (also, 'type','s')

cbrSelector('length','twelve') - Shows all color arrays that have 12 colors (also 'length',12 or any number 3-12)

# Color Map Selection
Once you know what you want use the 'name' key value pair

cmap = cbrSelector('name','BrBg') - Returns the BrBg color array as an 8x3 colormap
cmap = cbrSelector('name','Paired','length',12) - Returns the Paire color array as a 12x3 colormap

# Setting Current Color Map
You can now use colormap(cmap) to set the current color map to your new cbrSelector map

# Turning Plotting Off
cmap = cbrSelector('name','Paired','length',12,'plot',false) or 'plot','f' or 'plot','false'

# Creating the Maps from Scratch
If you're leery of the cbr.mat file that contains the color maps and want to create them this file on your own. First delete the cbr.mat file then use the command:

cbrSelector('create')

This will recreate the cbr.mat file from the text in the file cbr_cell.m. Additionally, you can use this to add extra color pallets.

# Other Licensey Stuff
## Per the ColorBrewer Website
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met: 
1. Redistributions as source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
2. The end-user documentation included with the redistribution, if any, must include the following acknowledgment: 
"This product includes color specifications and designs developed by Cynthia Brewer (http://colorbrewer.org/)." 
Alternately, this acknowledgment may appear in the software itself, if and wherever such third-party acknowledgments normally appear. 
4. The name "ColorBrewer" must not be used to endorse or promote products derived from this software without prior written permission. For written permission, please contact Cynthia Brewer at cbrewer@psu.edu. 
5. Products derived from this software may not be called "ColorBrewer", nor may "ColorBrewer" appear in their name, without prior written permission of Cynthia Brewer.
