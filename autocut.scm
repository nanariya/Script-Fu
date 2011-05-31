(define (script-fu-autocut-mcr image drawable )
(let* (
 (org-width (car (gimp-image-width image)))
 (org-height (car (gimp-image-height image)))
 (the-filename (car (gimp-image-get-filename image)))
 (new-filename (string-append (substring the-filename 0 (- (string-length the-filename) 4)) ".png"))
 )
(gimp-image-undo-group-start image)

    (gimp-selection-invert image)
    (gimp-edit-clear drawable)
    (gimp-selection-none image)
    (plug-in-autocrop 1 image drawable)
    (gimp-image-scale image 640 (* (car (gimp-image-height image)) (/ 640 (car (gimp-image-width image)))))
    (plug-in-colortoalpha 1 image drawable '(255 255 255))

    
    (file-png-save 
     1
     image
     drawable
     new-filename
     new-filename
     0 ;interlace
     9 ;compression
     0 ;background color
     0 ;gAMA
     0 ;offset
     1 ;pHYs
     1 ;time
     )
    
    (gimp-displays-flush)
    
    

(gimp-image-undo-group-end image)

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