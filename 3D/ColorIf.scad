
module color_if(c, predicate) {
    if (predicate) {
        color(c) children();
    } else {
        children();
    }
}
