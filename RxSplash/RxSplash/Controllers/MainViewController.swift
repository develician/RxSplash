//
//  MainViewController.swift
//  RxSplash
//
//  Created by killi8n on 30/09/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import ReactorKit
import Then
import SnapKit
import ReusableKit
import RxSwift
import RxCocoa
import RxViewController
import CGFloatLiteral


class MainViewController: BaseViewController, View {
    typealias Reactor = MainViewReactor
    
    
    struct Constant {
        static let perPageCount = 14
        static let orderBy = "latest"
    }
    
    init(reactor: Reactor) {
        super.init()
        self.reactor = reactor
        self.title = "UNSPLASH"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Reusable {
        static let imageCell = ReusableCell<ImageCell>()
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout).then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        $0.register(Reusable.imageCell)
        $0.refreshControl = self.refreshControl
    }
    
    let activityIndiactorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.activityIndiactorView)
        
    }
    
    override func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.activityIndiactorView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    func bind(reactor: Reactor) {
        
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.rx.viewDidLoad
            .map { Reactor.Action.getUnsplashList }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.collectionView.rx.isReachedBottom.map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.refreshControl.rx.controlEvent(.valueChanged).map { Reactor.Action.getUnsplashList }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.collectionView.rx.itemSelected.asObservable()
            .flatMap { [weak self] (indexPath: IndexPath) -> Observable<ImageCellReactor> in
                guard let imageCellReactor = self?.reactor?.currentState.sections[indexPath.section].items[indexPath.item] else { return Observable.empty() }
                return Observable.just(imageCellReactor)
            }
            .subscribe(onNext: { [weak self] (reactor: ImageCellReactor) in
                let detailViewReactor = DetailViewReactor()
                let detailViewController = DetailViewController(reactor: detailViewReactor, unsplash: reactor.currentState)
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.createDataSource()))
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.loading }
            .bind(to: self.activityIndiactorView.rx.isAnimating)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.refreshing }
            .bind(to: self.refreshControl.rx.isRefreshing)
            .disposed(by: self.disposeBag)
        
    }
    
    func createDataSource() -> UnsplashDataSourceType {
        return UnsplashDataSourceType(configureCell: { (dataSource, collectionView, indexPath, reactor) -> UICollectionViewCell in
            let cell = collectionView.dequeue(Reusable.imageCell, for: indexPath)
            cell.reactor = reactor
            return cell
        }, configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            return UICollectionReusableView()
        }, moveItem: { (dataSource, source, dest) in
            
        }, canMoveItemAtIndexPath: { (dataSource, indexPath) -> Bool in
            return false
        })
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



