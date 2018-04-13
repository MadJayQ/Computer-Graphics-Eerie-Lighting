var GroundMesh = (size) => {
    var colors = [];
    var vertices = [
        -size, 0, size,
        -size, 0, -size,
        size, 0,  -size,

        size, 0, -size,
        size, 0, size,
        -size, 0, size
    ];

    for(var i = 0; i < vertices.length; i++) {
        var c = GRASS.serialize();
        colors = colors.concat(c,c,c,c);
    }
    return {
        indices: () => { return undefined; },
        vertices: () => { return vertices; },
        color: () => { return colors; }
    };
};
