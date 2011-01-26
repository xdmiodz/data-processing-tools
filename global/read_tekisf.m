function [varargout] = read_tekisf(filename)
%----------------------------------------------------------------------------
%
% read_tekisf: read files in the `internal' data format of 
% Tektronix TDS3000-series oscilloscopes.
%
% invocation: 
%                read_tekisf('filename');   -- print some file-stats to stdout
%            y = read_tekisf('filename');  -- get just y-data
%        [x,y] = read_tekisf('filename');  -- get all result data
%   [x,y,head] = read_tekisf('filename');  -- get data and header-structure
% 	
%
% The original file 'isfread.m' from 
%	http://www.mathworks.com/matlabcentral/fileexchange/6247
% was written 17/8/2004 by John Lipp - CCLRC Rutherford Appleton Laboratory.
% It was downloaded on 2009-05-04 and adapted by Nathaniel Taylor in (at least)
% the following:
% 	separate x,y output
%	variable number of output-arguments, for convenience
%	check success of opening input file
%	explicit big-endian mode (seems right for our scopes)
%	accept variable header length based on string #520000 
%	  (not sure how important this is; no guarantee the string is always there)
%
%history
%22-01-11 change search string to #41000
%----------------------------------------------------------------------------

% input data
if isempty(filename) || ~ischar(filename),
	error('input argument must be a string (input file name)');
end
[fd, mesg] = fopen(filename,'r','ieee-be');
if fd<0,
	error('error opening input file: "%s"\n', mesg);
end

% header (ascii)
header_end_marker = '#41000';
head_chunk = char( fread(fd, [1,512], 'uchar') );
header_end_marker_starts = strfind(head_chunk, header_end_marker);
if length(header_end_marker_starts)<1,
    error('couldn''t find header end-marker string "%s"\n', header_end_marker);
end
if numel(header_end_marker_starts)<1,
    error('header end-marker string "%s" was found more than once: %s\n', ...
	 header_end_marker, num2str(header_end_marker_starts) );
end
header_length = header_end_marker_starts - 1 + length(header_end_marker);
frewind(fd);
header_string = char( fread(fd, [1,header_length], 'uchar') );
h = parseHead(header_string);

% data (binary)
inData = fread(fd, h.NR_PT, 'int16');
lowerXLimit = h.XZERO;
upperXLimit = ((h.NR_PT-1)* h.XINCR + h.XZERO);
x = [lowerXLimit:h.XINCR:upperXLimit].';
y = h.YMULT*(inData-h.YOFF);

% make output variables
if nargout==0,
	header
	fprintf( 'x range: %g -- %g, [min %g, max %g]\n', ...
		x(1), x(end), min(x), max(x) );
	fprintf( 'y range: %g -- %g, [min %g, max %g]\n', ...
		y(1), y(end), min(y), max(y) );
	varargout = {};
elseif nargout==1,
	varargout = { y };
elseif nargout==2,
	varargout = { x, y };
elseif nargout==3,
	varargout = { x, y, h };
else
	help read_tekisf;
	error('expected from zero to three output args: y ; x,y ; x,y,header');
end


%----------------------------------------------------------------------------
function h = parseHead(header_string)
[h.TYPE,rem] = strtok(header_string,':');
[h.BYT_NR, rem] = get_num(rem);
[h.BIT_NR, rem] = get_num(rem);
[h.ENCDG,rem] = get_string(rem);
[h.BN_FMT,rem] = get_string(rem);
[h.BYT_OR,rem] = get_string(rem);
[h.NR_PT, rem] = get_num(rem);
[h.WFID,rem] = get_string(rem);
[h.PT_FMT,rem] = get_string(rem);
[h.XINCR, rem] = get_num(rem);
[h.PT_OFF, rem] = get_num(rem);
[h.XZERO, rem] = get_num(rem);
[h.XUNIT,rem] = get_string(rem);
[h.YMULT, rem] = get_num(rem);
[h.YZERO, rem] = get_num(rem);
[h.YOFF, rem] = get_num(rem);
[h.YUNIT,rem] = get_string(rem);
[h.CURVE,rem] = get_string(rem);

%------------------------------------------------
function [rtnNum, remStr] = get_num(string)
[junk,rem] = strtok(string,' ');
[tmp, remStr] = strtok(rem,';');
rtnNum = str2num(tmp);

%------------------------------------------------
function [rtnStr, remStr] = get_string(string)
[junk,rem] = strtok(string,' ');
rem = strtrim(rem); % remove padding white space
[rtnStr,remStr] = strtok(rem,';');


%----------------------------------------------------------------------------

