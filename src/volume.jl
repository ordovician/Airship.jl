export  sphere_volume, ellipsoid_volume, cylinder_volume,
        sphere_area, cylinder_area , triangle_area, circle_area, rectangle_area,
        oblate_spheroid_area, prolate_spheroid_area

"Volume of sphere with radius `r`"
sphere_volume(r) = (4/3)*π*r^3

"Volume of an ellipsoid with radii `a`, `b` and `c`. This is like a rotated ellipse. Useful approximation to zepplins and flying saucers."
ellipsoid_volume(a, b, c) =  (4/3)*π*a*b*c

"Volume of cylinder with radius `r` and height `h`"
cylinder_volume(r, h) = circle_area(r)*h

"Surface area of a sphere"
sphere_area(r) = 4*π*r^2

"Surface area of a cylinder of height `h` and radius `r`"
cylinder_area(r, h) = 2*circle_area(r) + 2*π*r*h

"Area of a triangle"
triangle_area(b, h) = b*h/2

"Area of a circle with radius `r`"
circle_area(r) = π*r^2

"Area of rectangle with height `h` and width `w`"
rectangle_area(h, w) = h*w

"""
    oblate_spheroid_area(a, b)

Area of an ellipsoid which is disc shaped. That is, it is made from rotating an ellipse
around its minor axis (shortest axis).
`a` is the semi-minor axis and `b` the semi-major axis.
"""
function oblate_spheroid_area(a, b)
    α = acos(a/b)
    2π*(a^2 + (b^2/sin(α)) * log((1 + sin(α)/cos(α))) )

end

"""
    prolate_spheroid_area(a, b)

Area of an ellipsoid which is cigar shaped. That is, it is made from rotating an ellipse
around its major axis. Major axis is the longest axis.
`a` is the semi-minor axis and `b` the semi-major axis.
"""
function prolate_spheroid_area(a::Number, b::Number)
    @assert b > a "b is the semi-major axis and must thus be longer than semi-minor axis a"
    α = acos(a/b)
    2π*(a^2 + a*b*α/sin(α))
end
