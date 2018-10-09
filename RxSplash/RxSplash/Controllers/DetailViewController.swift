//
//  DetailViewController.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import UIKit
import ReactorKit
import Then
import SnapKit
import ReusableKit
import RxSwift
import RxCocoa
import RxDataSources

class DetailViewController: BaseViewController, View {
    typealias Reactor = DetailViewReactor
    
    var unsplash: Unsplash?
    
    struct Reusable {
        static let imageCell = ReusableCell<ImageCell>()
        static let userInfoCell = ReusableCell<UserInfoCell>()
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout).then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        $0.isPagingEnabled = true
        $0.register(Reusable.imageCell)
        $0.register(Reusable.userInfoCell)
    }
    
    init(reactor: Reactor, unsplash: Unsplash) {
        super.init()
        self.reactor = reactor
        self.unsplash = unsplash
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
    }
    
    override func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func bind(reactor: Reactor) {
        
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        self.rx.viewDidLoad.flatMap { [weak self] _ -> Observable<Unsplash> in
            guard let unsplash = self?.unsplash else { return Observable.empty() }
            return Observable.just(unsplash)
            }.map { (unsplash) -> Reactor.Action in
                return Reactor.Action.setInitialItem(unsplash)
        }.bind(to: reactor.action).disposed(by: self.disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.createDataSource()))
            .disposed(by: self.disposeBag)
    }
    
    func createDataSource() -> RxCollectionViewSectionedReloadDataSource<DetailSectionModel> {
        return RxCollectionViewSectionedReloadDataSource<DetailSectionModel>(configureCell: { (dataSource, collectionView, indexPath, detailSectionItem) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case let .ImageSectionItem(unsplash):
                let cell = collectionView.dequeue(Reusable.imageCell, for: indexPath)
                let reactor = ImageCellReactor(unsplash: unsplash)
                cell.reactor = reactor
                return cell
            case let .UserInfoSectionItem(user):
                let cell = collectionView.dequeue(Reusable.userInfoCell, for: indexPath)
                let reactor = UserInfoCellReactor(user: user)
                cell.reactor = reactor
                return cell
            }
        }, configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            return UICollectionReusableView()
        }, moveItem: { (dataSource, source, dest) in
        
        }, canMoveItemAtIndexPath: { (dataSource, indexPath) -> Bool in
            return false
        })
    }

}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: self.view.frame.height)
        case 1:
            return CGSize(width: collectionView.frame.width, height: UserInfoCell.Metric.profileImageViewSize + UserInfoCell.Metric.profileImageViewPadding * 2)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let navBarHeight = self.navigationController?.navigationBar.frame.height else { return 0 }
        return navBarHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let navBarHeight = self.navigationController?.navigationBar.frame.height else { return 0 }
        return navBarHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
}
