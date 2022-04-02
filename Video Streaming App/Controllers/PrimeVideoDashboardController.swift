//
//  PrimeVideoDashboardController.swift
//  Video Streaming App
//
//  Created by Samir on 4/1/22.
//

import UIKit
import Alamofire
import ProgressHUD

class PrimeVideoDashboardController: BaseParentViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [MediaCategory]()
    let mediaViewModel = MediaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Amazon Prime"

        configureTableView()
        
        parseDataSource()
    }
    
    
    /// Configures tableview cells, look and feel and generic behaviour.
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
        let galleryCarouselCellNib = UINib(nibName: "GalleryCarouselCell", bundle: Bundle.main)
        tableView.register(galleryCarouselCellNib, forCellReuseIdentifier: CellIdentifiers.galleryCarouselCellIdentifier)
        
        let carouselCellNib = UINib(nibName: "CarouselCell", bundle: Bundle.main)
        tableView.register(carouselCellNib, forCellReuseIdentifier: CellIdentifiers.carouselCellIdentifier)
    }
    
    
    func parseDataSource(){
        mediaViewModel.delegate = self
        mediaViewModel.loadMediaData()
        
        ProgressHUD.show()
    }

}

extension PrimeVideoDashboardController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSet = dataSource[indexPath.section]
        
        if let carouselType = dataSet.displayPattern{
            if carouselType == CarouselType.FULL_WIDTH_CELL.rawValue{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.galleryCarouselCellIdentifier) as? GalleryCarouselCell else{return UITableViewCell()}
                
                cell.configureCell(mediaCategory: dataSet)
                
                return cell
            }else if carouselType == CarouselType.SQUARE_CELL.rawValue || carouselType == CarouselType.RECT_CELL.rawValue{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.carouselCellIdentifier) as? CarouselCell else{return UITableViewCell()}
                
                cell.configureCell(mediaCategory: dataSet)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dataSet = dataSource[indexPath.section]
        
        if let carouselType = dataSet.displayPattern{
            if  carouselType == CarouselType.RECT_CELL.rawValue{
                let width = tableView.bounds.size.width / 2
                return width * 0.65
            }else if carouselType == CarouselType.SQUARE_CELL.rawValue{
                return tableView.bounds.size.width * 0.4
            }
        }
        
        return tableView.frame.size.width * 0.5625
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataSet = dataSource[section]
        let headerView = AppThemes.current.getHeaderForTitle(titleString: dataSet.categoryTitle ?? "")
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dataSet = dataSource[section]
        let headerView = AppThemes.current.getHeaderForTitle(titleString: dataSet.categoryTitle ?? "")
        
        return headerView.frame.size.height
    }
}

extension PrimeVideoDashboardController: MediaDelegate{
    func mediaLoaded(mediaCategory: [MediaCategory]?, error: Error?) {
        if let error = error{
            ProgressHUD.showError(error.localizedDescription)
        }else{
            ProgressHUD.dismiss()
            dataSource.append(contentsOf: mediaCategory ?? [])
        }
        
        
        
        tableView.reloadData()
    }
}
