import numpy as np
import cv2 as cv
import json
import sys

#calibrate face box enlargement after detection
TOP_SCALER = 0.56
SIDES_SCALER = 0.28

faceValues = []
cropCommands = [] 

face_cascade = cv.CascadeClassifier('haarcascade_frontalface_alt.xml')
eye_cascade = cv.CascadeClassifier('haarcascade_eye.xml')
img = cv.imread('input_image.jpg')
gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.3, 5)

for i in range(len(faces)):

    x = faces[i, 0]
    y = faces[i, 1]
    w = faces[i, 2]
    h = faces[i, 3]

    #add face x, y, width, and height to faceValues
    faceValues.append([x-int(w*SIDES_SCALER), y-int(h*TOP_SCALER), w+2*int(w*SIDES_SCALER), h+int(h*SIDES_SCALER)+int(h*TOP_SCALER)])

#create list of imagemagick commands to crop each face
for i in faceValues:
    command = 'convert input_image.jpg -crop ' + str(i[2])+'x'+str(i[3])+'+'+str(i[0])+'+'+str(i[1])+" cropped_face.jpg"
    cropCommands.append(command)

#dump imagemagick commands
json.dump([i for i in cropCommands], sys.stdout)



