; Auto-generated. Do not edit!


(cl:in-package joint_msg-msg)


;//! \htmlinclude joint_msg.msg.html

(cl:defclass <joint_msg> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (r
    :reader r
    :initarg :r
    :type cl:float
    :initform 0.0))
)

(cl:defclass joint_msg (<joint_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <joint_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'joint_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name joint_msg-msg:<joint_msg> is deprecated: use joint_msg-msg:joint_msg instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <joint_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joint_msg-msg:id-val is deprecated.  Use joint_msg-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'r-val :lambda-list '(m))
(cl:defmethod r-val ((m <joint_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader joint_msg-msg:r-val is deprecated.  Use joint_msg-msg:r instead.")
  (r m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <joint_msg>) ostream)
  "Serializes a message object of type '<joint_msg>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <joint_msg>) istream)
  "Deserializes a message object of type '<joint_msg>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<joint_msg>)))
  "Returns string type for a message object of type '<joint_msg>"
  "joint_msg/joint_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'joint_msg)))
  "Returns string type for a message object of type 'joint_msg"
  "joint_msg/joint_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<joint_msg>)))
  "Returns md5sum for a message object of type '<joint_msg>"
  "348422e71c7da9fe3e7cde970aaddd6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'joint_msg)))
  "Returns md5sum for a message object of type 'joint_msg"
  "348422e71c7da9fe3e7cde970aaddd6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<joint_msg>)))
  "Returns full string definition for message of type '<joint_msg>"
  (cl:format cl:nil "int32 id~%float64 r~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'joint_msg)))
  "Returns full string definition for message of type 'joint_msg"
  (cl:format cl:nil "int32 id~%float64 r~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <joint_msg>))
  (cl:+ 0
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <joint_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'joint_msg
    (cl:cons ':id (id msg))
    (cl:cons ':r (r msg))
))
