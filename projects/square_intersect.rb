def intersecting_squares(s1, s2)
  intersect?(s1, s2[0])|| intersect?(s1, s2[1])|| intersect?(s2, s1[0])|| intersect?(s2, s1[1])
end

def intersect?(square, corner)
  x_intersect?(square, corner) && y_intersect?(square, corner)
end

def x_intersect?(square, corner)
  corner[0].between?(square[0][0], square[1][0])
end

def y_intersect?(square, corner)
  corner[1].between?(square[0][1], square[1][1])
end
