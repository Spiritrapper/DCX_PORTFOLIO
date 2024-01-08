import torch
from transformers import AutoModelForImageClassification, AutoProcessor
import cv2

# Load the model
model = AutoModelForImageClassification.from_pretrained("chbh7051/vit-driver-drowsiness-detection")
processor = AutoProcessor.from_pretrained("chbh7051/vit-driver-drowsiness-detection")

# Initialize webcam
cap = cv2.VideoCapture(0)

while True:
    frame = cap.read()
    if frame is None:
        print("No frame available. Check video source.")
        break
    
    # Preprocess the frame
    inputs = processor(images=frame, return_tensors="pt")

    # Predict drowsiness
    with torch.no_grad():
        outputs = model(**inputs)

    # Interpret the model's output
    # ...

    # Show the frame
    cv2.imshow("Frame", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()