import face_recognition
import json

arr = ["/src/muka.jpg", "/src/alex.jpg", "/src/jesse.jpg"]
unknown_image = face_recognition.load_image_file("tmp/photo.jpg")
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]

for image in arr:
    known_image = face_recognition.load_image_file(image)
    known_encoding = face_recognition.face_encodings(known_image)[0]
    if face_recognition.compare_faces([known_encoding], unknown_encoding):
        print(True)

print(False)