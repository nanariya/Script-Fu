(define
 (script-fu-autocut-mcr image drawable )
 (let* (
  (org-width (car (gimp-image-width image)))
  (org-height (car (gimp-image-height image)))
  (the-filename (car (gimp-image-get-filename image)))
  (new-filename (string-append (substring the-filename 0 (- (string-length the-filename) 4)) ".jpg"))
  (temp 0)
  (image-id image)
  (draw-id drawable)
 )
    (gimp-image-undo-group-start image)

    (gimp-selection-invert image)
    (gimp-edit-clear drawable)
    (gimp-selection-none image)
    (plug-in-autocrop 1 image drawable)
    (gimp-image-scale image 640 (* (car (gimp-image-height image)) (/ 640 (car (gimp-image-width image)))))
    (plug-in-colortoalpha 1 image drawable '(255 255 255))

	(set! temp (car (gimp-layer-new image org-width org-height 1 "white" 100 0)))
	(gimp-drawable-fill temp WHITE-FILL)
	(gimp-image-add-layer image temp 1)
	
	(gimp-image-flatten image-id)
    
    (file-jpeg-save
     1
     image-id
     (car (gimp-image-get-active-drawable image-id))
     new-filename
     new-filename
     0.8 ; quality 0<1
     0   ; smoothing 0<1
     0   ; optimize
     0   ; progressive
     ""  ; comment
     0   ; subsmp
     0   ; baseline
     0   ; restart
     0   ; dct
    )
    
    
    (gimp-image-clean-all image)
    
    (gimp-displays-flush)
    
    

    (gimp-image-undo-group-end image)
    (gimp-display-delete 1)

 )
)

(script-fu-register
 "script-fu-autocut-mcr"
 "<Toolbox>/Xtns/Auto Cut"
 "autocrop and autoresize 640x(X) and autosave (X.png)"
 "Nanariya"
 "copyright 2011, Nanariya"
 "May 31, 2011"
 ""
    SF-IMAGE      "Image"     0
    SF-DRAWABLE   "Drawable"  0
)