;; Auto-generated. Do not edit!


(when (boundp 'joint_msg::joint_msg)
  (if (not (find-package "JOINT_MSG"))
    (make-package "JOINT_MSG"))
  (shadow 'joint_msg (find-package "JOINT_MSG")))
(unless (find-package "JOINT_MSG::JOINT_MSG")
  (make-package "JOINT_MSG::JOINT_MSG"))

(in-package "ROS")
;;//! \htmlinclude joint_msg.msg.html


(defclass joint_msg::joint_msg
  :super ros::object
  :slots (_id _r ))

(defmethod joint_msg::joint_msg
  (:init
   (&key
    ((:id __id) 0)
    ((:r __r) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _r (float __r))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; float64 _r
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; float64 _r
       (sys::poke _r (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _r
     (setq _r (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get joint_msg::joint_msg :md5sum-) "348422e71c7da9fe3e7cde970aaddd6e")
(setf (get joint_msg::joint_msg :datatype-) "joint_msg/joint_msg")
(setf (get joint_msg::joint_msg :definition-)
      "int32 id
float64 r

")



(provide :joint_msg/joint_msg "348422e71c7da9fe3e7cde970aaddd6e")


