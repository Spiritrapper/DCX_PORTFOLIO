from ultralytics import YOLO
import cv2

# model = YOLO("C:/Users/smhrd/Downloads/bestcigar.pt")
# model = YOLO("yolov8n.pt")
# model.predict(source = "0", show = True, conf = 0.5)



model = YOLO("C:\\eGovFrame-4.0.0\\workspace.edu\\Z_Project5\\src\\Flask\\project\\face.pt")
# model = YOLO("yolov8n.pt")
# model = YOLO("C:/Users/smhrd/Downloads/second_try.pt")


cap = cv2.VideoCapture(0)  # Assuming '0' is the default camera index, change it if needed

while True:
    ret, frame = cap.read()

    # Perform object detection on the frame
    results = model.predict(frame, show = True, conf=0.5)
    for result in results:
        boxes = result.boxes.cpu().numpy()                         # get boxes on cpu in numpy
        for box in boxes:  
            class_name = result.names[int(box.cls[0])]
            if class_name == "yawn":
                print("하품 감지됨")
            print(result.names[int(box.cls[0])])   # result.names[int(box.cls[0])]-> str 타입으로 face 또는 cigarette

    # Display the results
    # cv2.imshow('Object Detection', frame)

    # Check for the 'q' key to exit the loop
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the webcam and close OpenCV windows
cap.release()
cv2.destroyAllWindows()