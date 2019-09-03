function h = apodization ( XY, Z , radius, center )

if length(center) == 3 
    h = zeros(XY, XY, Z);
    for z = 1:Z
        zc = z - center(3);
        for y = 1:XY
            yc = y - center(1);
            for x = 1:XY
                xc = x - center(2);
                r = sqrt(xc*xc + yc*yc + zc*zc ); % so that the sphere is shifted to the center
                if r < radius
                    if r==0
                        h(y,x,z)=1;
                    else
                        h(y,x,z) = (radius-r)./radius;
                    end
                end
            end
        end
    end
    h = h./max(max(max(h)));
else
    h = zeros(XY, XY);
    for y = 1:XY
        yc = y - center(1);
        for x = 1:XY
            xc = x - center(2);
            r = sqrt(xc*xc + yc*yc ); % so that the sphere is shifted to the center
            if r < radius
                if r==0
                    h(y,x)=1;
                else
                    h(y,x) = (radius-r)./radius;
                end
            end
        end
    end
    h = h./max(max(h));
end