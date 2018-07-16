import face_recognition
import json
import sys

#load images of the faces we want to recognize
known_faces = ["/src/muka.jpg", "/src/alex.jpg", "/src/jesse.jpg"]

#load the cropped image from the previous step
unknown_image = face_recognition.load_image_file("/tmp/photo.jpg")
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]

result = "unrecognized-face"
#determine if the cropped image matches with one of the faces, and print result
for image in known_faces:
    known_image = face_recognition.load_image_file(image)
    known_encoding = face_recognition.face_encodings(known_image)[0]
    if face_recognition.compare_faces([known_encoding], unknown_encoding)[0]:
        result = "recognized-face"
print(result)