function [Z,sz,mv]    =  load_HSI( Dir, image, sf )
fpath         =   fullfile( fullfile(Dir, image,image), '*.png');
im_dir        =   dir(fpath);
bands         =   length(im_dir);
filestem      =   char(strcat(Dir, '/',image, '/', image,'/', image));

for band = 1:bands
    filesffx    =  '.png';    
    if band < 10
        prefix  =  '_0';
    else
        prefix  =  '_';
    end    
    number      =   strcat( prefix, int2str(band) );
    filename    =   strcat( filestem, number, filesffx );
    Z           =   imread(filename);
    if  band==1
        sz        =   size(Z);
        sz        =   sz(1:2);
        sz        =   sz - mod(sz, sf);
        s_Z       =   zeros(bands, sz(1)*sz(2));        
    end
    Z              =   Z(1:sz(1), 1:sz(2));
    s_Z(band, :)   =   Z(:);
end
mv     =  max(s_Z(:));
if mv<256
    mv=255;
else
    mv = 65535;
end
Z      =  s_Z/mv;
end