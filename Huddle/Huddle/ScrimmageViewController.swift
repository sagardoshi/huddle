//
//  ScrimmageViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/17/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}



class ScrimmageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagesDirectoryPath: URL!
    var imagePicker: UIImagePickerController!
    var photoToSave: UIImage! = UIImage(named: "scrimmageImage.png")
    var compressionMultiplier: CGFloat = 0.25
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var subcontentStackViewToHide: UIStackView!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    
    // When an image is "picked" it will return through this function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = image
            photoToSave = image
        } else {
            print("Dunno why, but looks like the chosen image wasn't a UIImage, and it needs to be.") // ERROR MESSAGE
        }
    }
    
    @IBAction func importImage(_ sender: UIButton) {
        
        // Hide text and camera button
        subcontentStackViewToHide.isHidden = true
        // Replace with overlay
        overlayView.isHidden = false
        
        
        // Take image (I think this ultimately calls the imagePickerController function...)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImage(imageToSave: UIImage!) {
        
        // Get unique name for file path
        var fileName: String = NSDate().description
        fileName = fileName.replacingOccurrences(of: " ", with: "")
        fileName = fileName.replacingOccurrences(of: "/", with: "")
        fileName = "ImagePicker/\(fileName).png"
        print("***** Here's fileName after all the string adjustments: " + fileName)
        
        imagesDirectoryPath = getDocumentsDirectory()
        imagesDirectoryPath.appendPathComponent(fileName)
        print("***** Here's imagesDirectoryPath AFTER appending the fileName: \(imagesDirectoryPath)")
        print()
        let finalImagePath = imagesDirectoryPath!
        
        
        // Compress image
        let thumbnail = imageToSave.compress(toPercentage: compressionMultiplier)
        
        var imageData = UIImagePNGRepresentation(thumbnail!)
        
        // Fix the error in PNG Representation where its photos are rotated left using updateImageOrientationUpSide() function
        if let updatedImage = thumbnail?.updateImageOrientionUpSide() {
            imageData = UIImagePNGRepresentation(updatedImage)
        }
        
        
        
        
        do {
            try imageData!.write(to: finalImagePath, options: .atomic)
            print("HOOORAY!!! image as data WAS written to a path: \(finalImagePath)")
        } catch {
            print("BOOOO... image as data WAS NOT written to this path: \(finalImagePath)")
        }


    }
    
    
    func createImagesFolder () {
        
        if(!FileManager.default.fileExists(atPath: imagePickerPath.path)) {
            print("There was no existing ImagePicker folder.")
            do {
                print("I am creating the folder where the images will be stored: \(imagePickerPath.path)")
                try FileManager.default.createDirectory(at: imagePickerPath, withIntermediateDirectories: true, attributes: nil)
                print("I have finished creating the folder where the images will be stored: \(imagePickerPath.path)")
            } catch {
                print("Something went wrong while creating a new folder to hold the images.")
            }
            
        } else {
            print("There was an existing ImagePicker folder.")
            print("Here's the path for the already existing folder: \(imagePickerPath.path)")
        }
        
        
    }
    
    
    @IBAction func scrimmageComplete(_ sender: Any) {
        score += 30
        level += 1
        saveImage(imageToSave: photoToSave!)
    }
    

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    
    
    // All below is related to menu animation
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    
    var menuVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 5, height: 5)
        menuView.layer.shadowRadius = 5
        
        createImagesFolder() // Creates storage folder if and only if it doesn't already exist
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if menuVisible {
            toggleMenu(self)
        }
    }
    
    
    @IBAction func toggleMenu(_ sender: Any) {
        menuView.isHidden = false
        if (!menuVisible) {
            menuTopConstraint.constant = 0
        } else {
            menuTopConstraint.constant = -300
        }
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        menuVisible = !menuVisible
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Image extension
extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    func compress(toPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        draw(in: CGRect(origin: .zero, size: canvasSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
