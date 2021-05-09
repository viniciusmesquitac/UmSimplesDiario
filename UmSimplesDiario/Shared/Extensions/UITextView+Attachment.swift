//
//  UITextView+Attachment.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 09/05/21.
//

import UIKit

extension UITextView {

    func setAttachment(image: UIImage) {
        /* A text attachment object contains either an NSData object or an FileWrapper object,
         which in turn holds the contents of the attached file. */
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Resize
        let imageSize = imageAttachment.image!.size.width
        let frameSize = self.frame.size.width - 100
        let scaleFactor = imageSize / frameSize
        // Scale the image down
        imageAttachment.image = UIImage(cgImage: imageAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        // Get String attachment
        let myString = NSMutableAttributedString(string: self.text)
        // create attributed string from image so we can append it
        let imageString = NSAttributedString(attachment: imageAttachment)
        // add the NSTextAttachment wrapper to our original string, then add some more text.
        myString.append(imageString)
        // set the text for the UITextView
        self.attributedText = myString
    }
}
