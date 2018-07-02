import numpy as np
import cv2 as cv

#calibrates face box enlargement after detection
TOP_SCALER = 0.56
SIDES_SCALER = 0.28

output = []

face_cascade = cv.CascadeClassifier('haarcascade_frontalface_alt.xml')
eye_cascade = cv.CascadeClassifier('haarcascade_eye.xml')
img = cv.imread('group-people-wearing-sunglasses-29654821.jpg')
gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.3, 5)

for i in range(len(faces)):

    x = faces[i, 0]
    y = faces[i, 1]
    w = faces[i, 2]
    h = faces[i, 3]

    #draw rectangle around face
    cv.rectangle(img,(x-int(w*SIDES_SCALER), y-int(h*TOP_SCALER)),(x+w+int(w*SIDES_SCALER),y+h+int(h*SIDES_SCALER)),(255,0,0),2)

    #add face x, y, width, and height to output
    output.append([x-int(w*SIDES_SCALER), y-int(h*TOP_SCALER), w+2*int(w*SIDES_SCALER), h+int(h*SIDES_SCALER)+int(h*TOP_SCALER)])

print 'convert group-people-wearing-sunglasses-29654821.jpg -crop ' 
print output[2][2]
print 'x'
print output[2][3]
print '+'
print output[2][0]
print '+'
print output[2][1]

cv.imshow('img',img)
cv.waitKey(0)
cv.destroyAllWindows()


