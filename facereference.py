import face_recognition
known_image = face_recognition.load_image_file("0.jpg")
unknown_image = face_recognition.load_image_file("photo.jpg")
eli_image = face_recognition.load_image_file("messi.jpg")

muka_encoding = face_recognition.face_encodings(known_image)[0]
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]
eli_encoding = face_recognition.face_encodings(eli_image)[0]

results = face_recognition.compare_faces([muka_encoding], unknown_encoding)
results2 = face_recognition.compare_faces([muka_encoding], eli_encoding)
print("This should be true: "+str(results))
print("This should be false "+str(results2))