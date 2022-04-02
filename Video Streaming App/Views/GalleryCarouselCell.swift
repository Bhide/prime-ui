//
//  GalleryCarouselCell.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import UIKit

class GalleryCarouselCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var medias: MediaCategory?
    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }
    
    func configureCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "MediaThumbnailCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: CellIdentifiers.mediaThumbnailCellIdentifier)
    }
    
    func configureCell(mediaCategory: MediaCategory){
        medias = mediaCategory
        
        pageControl.numberOfPages = medias?.medias.count ?? 0
        pageControl.currentPage = 0
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
        
        collectionView.reloadData()
    }
    
    @objc func changeImage() {
         if counter < (medias?.medias.count ?? 0) {
              let index = IndexPath.init(item: counter, section: 0)
              self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageControl.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageControl.currentPage = counter
               counter = 1
           }
      }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timer.invalidate()
    }
    
}

extension GalleryCarouselCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.mediaThumbnailCellIdentifier, for: indexPath) as? MediaThumbnailCollectionViewCell else{return UICollectionViewCell()}
        
        if let medias = medias{
            let media = medias.medias[indexPath.row]
            
            cell.configure(media: media)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = medias else{return 0}
        return category.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width * 0.5625)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint("scrollViewDidEndDecelerating index: \(indexOfMajorCell())")
        
        performManualPagination()
    }
    
    private func performManualPagination(){
        let pageWidth = collectionView.frame.width
        let currentPage:CGFloat = collectionView.contentOffset.x / pageWidth
        
        if 0 != fmodf(Float(currentPage), 1.0){
            pageControl.currentPage = Int(currentPage + 1)
        }else{
            pageControl.currentPage = Int(currentPage)
        }
    }
    
    private func indexOfMajorCell() -> Int {
        
        let itemWidth = CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height).width //cardsCollectionView.collectionViewLayout.//collectionViewLayout.itemSize.width
        let proportionalOffset = collectionView.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(medias?.medias.count ?? 0, index))
        return safeIndex
    }
    
}
