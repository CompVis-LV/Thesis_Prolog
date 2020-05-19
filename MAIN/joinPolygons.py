import numpy as np
import argparse
import cv2
import scipy.spatial as spatial
import main as m

def join_polygons(faces, value):
    for fc in range(value):
        for a in range(value):
            if fc != a:
                for x in range(len(faces["%s" % (fc)]['polygon'])):
                    point_tree = spatial.cKDTree(faces["%s" % (a)]['polygon'])
                    common = (point_tree.query_ball_point(faces["%s" % (fc)]['polygon'][x], 15))
                    for c in range(len(common)):
                        print("start change")
                        p1 = faces["%s" % (fc)]['polygon'][x]
                        p2 = faces["%s" % (a)]['polygon'][common[c]]
                        print(p1)
                        print(p2)
                        #ADD moves to closest point it joins with, cant move to a point it already is at
                        avg = (p1[0]+p2[0])/2, (p1[1]+p2[1])/2
                        print(avg)
                        faces["%s" % (fc)]['polygon'][x] = avg
                        faces["%s" % (a)]['polygon'][common[c]] = avg
                        if a not in faces["%s" % (fc)]["joins"]:
                            faces["%s" % (fc)]["joins"].append(a)
    return(faces)


def main():
    faces = {'0': {'polygon': [(333.78571428571433, 74.04545454545445), (200.66883116883113, 138.98051948051938), 
    (364.9139610389611, 227.2516233766233), (489.62987012987014, 133.78571428571422)], 'joins': [], 'angle': [], 
    'vector': [-0.0032138983, -0.23981544, 0.6080499]}, '1': {'polygon': [(200.66883116883113, 138.98051948051938), 
    (213.0064935064935, 250.6688311688311), (359.11038961038963, 342.2272727272727), (364.9748376623377, 227.31249999999991)], 
    'joins': [], 'angle': [], 'vector': [-0.15510413, 0.121414326, 0.7831795]}, '2': {'polygon': [(364.9748376623377, 227.31249999999991), 
    (489.62987012987014, 133.78571428571422), (468.8506493506494, 241.57792207792204), (359.11038961038963, 342.2272727272727)], 
    'joins': [], 'angle': [], 'vector': [0.23467888, 0.13740554, 0.70799935]}}
    print(faces)
    value = 3
    joinedFaces = join_polygons(faces, value)
    print(joinedFaces)
    faces =  m.find_angle_between(faces)
    print(faces)
    csv_write(faces)
    

if __name__ == "__main__":
    main()



{'0': {'polygon': [(333.78571428571433, 74.04545454545445), (200.66883116883113, 138.98051948051938), (364.95391132305195, 227.29157366071422), 
(489.62987012987014, 133.78571428571422)], 'joins': [1, 2], 'angle': [0.5587109496632551, 0.6428300488851255], 
'vector': [-0.0032138983, -0.23981544, 0.6080499]}, 

'1': {'polygon': [(200.66883116883113, 138.98051948051938), (213.0064935064935, 250.6688311688311), (359.11038961038963, 342.2272727272727), 
(364.9548625202922, 227.29252485795448)], 'joins': [0, 2], 'angle': [0.5587109496632551, 0.5092295149277393], 
'vector': [-0.15510413, 0.121414326, 0.7831795]}, 

'2': {'polygon': [(364.9548625202922, 227.29252485795448), (489.62987012987014, 133.78571428571422), (468.8506493506494, 241.57792207792204), 
(359.11038961038963, 342.2272727272727)], 'joins': [0, 1], 'angle': [0.6428300488851255, 0.5092295149277393], 
'vector': [0.23467888, 0.13740554, 0.70799935]}}





