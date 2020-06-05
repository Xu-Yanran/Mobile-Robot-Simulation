
(cl:in-package :asdf)

(defsystem "joint_msg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "joint_msg" :depends-on ("_package_joint_msg"))
    (:file "_package_joint_msg" :depends-on ("_package"))
  ))