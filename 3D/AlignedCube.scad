AlignedCube([1, 2, 3], alignment = [-1, 0, 1]);

module AlignedCube(dim, alignment) {
    translate(array_mul(dim, [-.5,-.5,-.5], alignment)) cube(dim, true);
    
    function array_mul(a, b, c, d, e) = (c != undef)
        ? array_mul(array_mul(a, b), c, d, e)
        : [for(n=[0:min(len(a),len(b))-1])a[n]*b[n]];
}
