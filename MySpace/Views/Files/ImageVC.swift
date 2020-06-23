//
//  ImageVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/16/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class ImageVC: BaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let vm = ImageVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self)
        bindData()
    }
    
    override func bindData() {
        super.bindData()
        FileContaintsVM.listImages.subscribe(onNext: { lst in
            self.vm.images = lst.map{ image in
                let photo = SKPhoto.photoWithImageURL(image.file_url ?? "")
                photo.shouldCachePhotoURLImage = true
                return photo
            }
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension ImageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FileContaintsVM.listImages.value.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell: ImageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configCell(FileContaintsVM.listImages.value[indexPath.row])
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.width / 4.0
           return CGSize(width: width, height: width)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 2. create PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: vm.images)
        browser.initializePageIndex(indexPath.row)
        present(browser, animated: true, completion: {})
    }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets.zero
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
}
