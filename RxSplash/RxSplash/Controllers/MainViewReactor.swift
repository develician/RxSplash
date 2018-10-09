//
//  MainViewReactor.swift
//  RxSplash
//
//  Created by killi8n on 30/09/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

typealias UnsplashSectionModel = SectionModel<Int, ImageCellReactor>
typealias UnsplashDataSourceType = RxCollectionViewSectionedReloadDataSource<UnsplashSectionModel>

class MainViewReactor: Reactor {
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    enum Action {
        case getUnsplashList
        case loadMore
        
    }
    
    enum Mutation {
        case setUnsplashList(sections: [UnsplashSectionModel])
        case addUnsplashList(sectionItems: [ImageCellReactor])
        case setLoading(loading: Bool)
        case setRefreshing(refreshing: Bool)
    }
    
    struct State {
        var sections: [UnsplashSectionModel] = []
        var page: Int = 1
        var loading: Bool = true
        var lastPage: Bool = false
        var refreshing: Bool = false
    }
    
    
    var initialState: State = State()
    var provider: ServiceProviderType
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getUnsplashList:
            let getListObservable = provider.unsplashService.getUnsplashList(page: 1, perPage: MainViewController.Constant.perPageCount, orderBy: MainViewController.Constant.orderBy).flatMap({ (unsplashList: [Unsplash]) -> Observable<Mutation> in
                let sectionItems = unsplashList.map(ImageCellReactor.init)
                let section = UnsplashSectionModel(model: 0, items: sectionItems)
                return Observable.just(Mutation.setUnsplashList(sections: [section]))
            })
            return Observable.concat([
                    Observable.just(Mutation.setRefreshing(refreshing: true)),
                    getListObservable,
                    Observable.just(Mutation.setRefreshing(refreshing: false))
                ])
        case .loadMore:
            if self.currentState.loading || self.currentState.lastPage {
                return Observable.empty()
            }
            let getListObservable = provider.unsplashService.getUnsplashList(page: self.currentState.page, perPage: MainViewController.Constant.perPageCount, orderBy: MainViewController.Constant.orderBy).flatMap({ (unsplashList: [Unsplash]) -> Observable<Mutation> in
                let sectionItems = unsplashList.map(ImageCellReactor.init)
                return Observable.just(Mutation.addUnsplashList(sectionItems: sectionItems))
            })
            return Observable.concat([
                    Observable.just(Mutation.setLoading(loading: true)),
                    getListObservable,
                    Observable.just(Mutation.setLoading(loading: false))
                ])
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setUnsplashList(let sections):
            state.sections = sections
            state.page += 1
            state.loading = false
            return state
        case let .addUnsplashList(sectionItems):
            for i in 0 ..< sectionItems.count {
                state.sections[0].items.append(sectionItems[i])
            }
            if sectionItems.count < MainViewController.Constant.perPageCount {
                state.lastPage = true
                return state
            }
            state.page += 1
            return state
        case let .setLoading(loading):
            state.loading = loading
            return state
        case let .setRefreshing(refreshing):
            state.refreshing = refreshing
            state.page = 2
            state.lastPage = false
            return state
        }
    }
    
    
}
