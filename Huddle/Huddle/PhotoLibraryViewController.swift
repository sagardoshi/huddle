//
//  PhotoLibraryViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/29/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit
class PhotoLibraryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    var menuVisible = false
    
    
    @IBOutlet weak var noPhotosView: UIView!
    
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    @IBOutlet weak var photoLibraryCollectionView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10)
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate var selectedPhotos = [UIImage]()
    
    
    // This identifies the chosen photo to later expand and fill the screen
    var largePhotoIndexPath: IndexPath? {
        didSet {
            var indexPaths = [IndexPath]()
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath as IndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue as IndexPath)
            }
            photoLibraryCollectionView?.performBatchUpdates({
                self.photoLibraryCollectionView?.reloadItems(at: indexPaths)
            }) { completed in
                if let largePhotoIndexPath = self.largePhotoIndexPath {
                    self.photoLibraryCollectionView?.scrollToItem(
                        at: largePhotoIndexPath as IndexPath,
                        at: .centeredVertically,
                        animated: true)
                }
            }
        }
    }
    
    
    var deletion: Bool = false {
        didSet {
            photoLibraryCollectionView?.allowsMultipleSelection = deletion
            photoLibraryCollectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedPhotos.removeAll(keepingCapacity: false) // Empties the array to re-use now
            
            guard let deleteButton = self.navigationItem.rightBarButtonItems?.first else {
                return
            }
            
            guard deletion else {
                navigationItem.setRightBarButtonItems([deleteButton], animated: true)
                return
            }
            
            if let _ = largePhotoIndexPath  {
                largePhotoIndexPath = nil
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotosIntoArray()
        
        if titles.count == 0 {
            noPhotosView.isHidden = false
        }
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 5, height: 5)
        menuView.layer.shadowRadius = 5
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
    
    
    
    
    
    
    
    func loadPhotosIntoArray() {
        
        // Get all the file titles that are inside of the ImagePicker folder
        
        do {
            try titles = FileManager.default.contentsOfDirectory(atPath: imagePickerPath.path)
            print("Was able to fill out titles.")
        } catch {
            print("Couldn't extract contents from the ImagePicker folder at this location: \(imagePickerPath.path)")
        }
        
        // Extract images of all files inside of ImagePicker folder
        if titles.count > 0 {
            for title in titles {
                let imageLocation = imagePickerPath.path + ("/\(title)")
                let actualImage = UIImage(contentsOfFile: imageLocation)
                images.append(actualImage!)
                
            }
        } else {
            print("There were no photos in the ImagePicker folder!! :-(")
        }
        print("In Huddle Home and there are this many images: " + "\(images.count)")
    }
    
    
    
    @IBAction func trashPhotos(_ sender: UIBarButtonItem) {
        do {
            let filePaths = try FileManager.default.contentsOfDirectory(atPath: imagePickerPath.path)
            for (index, filePath) in filePaths.enumerated() {
                print("Deleting photo " + "\(index)" + "...")
                try FileManager.default.removeItem(atPath: imagePickerPath.path + "/" + filePath)
            }
            print("ImagePicker folder fully deleted")
        } catch {
            print("Could not clear imagePicker folder: \(error)")
        }
        
        guard !selectedPhotos.isEmpty else {
            deletion = !deletion
            return
        }
        
        guard deletion else {
            return
        }
    }
    
    
    
    
    
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        let finalPhoto = images[indexPath.item]
        cell.myImageView.image = finalPhoto
//        cell.myImageView.backgroundColor = UIColor.yellow
        
        
        cell.activityIndicator.stopAnimating()
        
        
//        guard indexPath == largePhotoIndexPath else {
//            cell.myImageView.image = finalPhoto
//            return cell
//        }
//        
//        //3
//        guard flickrPhoto.largeImage == nil else {
//            cell.imageView.image = flickrPhoto.largeImage
//            return cell
//        }
//        
//        //4
//        cell.imageView.image = flickrPhoto.thumbnail
//        cell.activityIndicator.startAnimating()
//        
//        //5
//        flickrPhoto.loadLargeImage { loadedFlickrPhoto, error in
//            
//            //6
//            cell.activityIndicator.stopAnimating()
//            
//            //7
//            guard loadedFlickrPhoto.largeImage != nil && error == nil else {
//                return
//            }
//            
//            //8
//            if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell,
//                indexPath == self.largePhotoIndexPath  {
//                cell.imageView.image = loadedFlickrPhoto.largeImage
//            }
//        }
        
        return cell
    }
    
    
    
    
    
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        
        guard deletion else {
            return
        }
        
        selectedPhotos.append(images[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("You DEselected cell #\(indexPath.item)!")
        
        guard deletion else {
            return
        }
        
        
        if let index = selectedPhotos.index(of: images[indexPath.item]) {
            selectedPhotos.remove(at: index)
        }

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard !deletion else {
            return true
        }
        
        largePhotoIndexPath = largePhotoIndexPath == indexPath ? nil : indexPath
        return false
    }
    
    
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath == largePhotoIndexPath {
            let bigPhoto = photoLibraryCollectionView.cellForItem(at: indexPath)
            var size = collectionView.bounds.size
            size.height -= topLayoutGuide.length
            size.height -= (sectionInsets.top + sectionInsets.bottom)
            size.width -= (sectionInsets.left + sectionInsets.right)
            return (bigPhoto?.sizeThatFits(size))!
        }
        
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
