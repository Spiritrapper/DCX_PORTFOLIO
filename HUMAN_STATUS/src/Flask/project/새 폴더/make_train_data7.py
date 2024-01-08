import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
import cv2
import requests
import numpy as np
from transformers import AutoImageProcessor, AutoModelForImageClassification

import tensorflow as tf

# Load the model and processor
processor = AutoImageProcessor.from_pretrained("google/vit-base-patch16-224")
model = AutoModelForImageClassification.from_pretrained("google/vit-base-patch16-224")

stream_url = "http://127.0.0.1:3000"

# Initialize a request to the video stream
r = requests.get(stream_url, stream=True)

if r.status_code == 200:
    bytes = b''
    for chunk in r.iter_content(chunk_size=1024):
        bytes += chunk
        a = bytes.find(b'\xff\xd8') # JPEG start
        b = bytes.find(b'\xff\xd9') # JPEG end
        if a != -1 and b != -1:
            jpg = bytes[a:b+2] # Actual image in bytes
            bytes = bytes[b+2:] # Remove processed bytes

            # Decode the JPEG image to a numpy array
            frame = cv2.imdecode(np.frombuffer(jpg, dtype=np.uint8), cv2.IMREAD_COLOR)

            # Process and display the frame as needed
            # Preprocess the frame
            inputs = processor(images=frame, return_tensors="pt")

            # Apply the model
            outputs = model(**inputs)

            # Postprocess outputs and display results (this part depends on your application)

            # Display the frame
            cv2.imshow('Frame', frame)

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
else:
    print("Received an error from the server, cannot retrieve the stream.")

cv2.destroyAllWindows()
