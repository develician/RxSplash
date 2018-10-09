//
//  DetailViewReactor.swift
//  RxSplash
//
//  Created by killi8n on 05/10/2018.
//  Copyright © 2018 killi8n. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

enum DetailSectionModel {
    case ImageSection(title: String, items: [DetailSectionItem])
    case UserInfoSection(title: String, items: [DetailSectionItem])
}

enum DetailSectionItem {
    case ImageSectionItem(unsplash: Unsplash)
    case UserInfoSectionItem(user: User)
}

extension DetailSectionModel: SectionModelType {
    typealias Item = DetailSectionItem
    
    var items: [DetailSectionItem] {
        switch self {
        case .ImageSection(title: _, items: let items):
            return items.map { $0 }
        case .UserInfoSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailSectionModel, items: [DetailSectionItem]) {
        switch original {
        case let .ImageSection(title: title, items: _):
            self = .ImageSection(title: title, items: items)
        case let .UserInfoSection(title: title, items: _):
            self = .UserInfoSection(title: title, items: items)
        }
    }
}

extension DetailSectionModel {
    var title: String {
        switch self {
        case .ImageSection(title: let title, items: _):
            return title
        case .UserInfoSection(title: let title, items: _):
            return title
        }
    }
}

class DetailViewReactor: Reactor {
    
    init() {
        
    }
    
    enum Action {
        case setInitialItem(Unsplash)
    }
    
    enum Mutation {
        case setSections(Unsplash)
    }
    
    struct State {
        var sections: [DetailSectionModel] = []
    }
    
    var initialState = State()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setInitialItem(unsplash):
            return Observable.just(Mutation.setSections(unsplash))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSections(unsplash):
            state.sections.append(DetailSectionModel.ImageSection(title: "ImageSection", items: [DetailSectionItem.ImageSectionItem(unsplash: unsplash)]))
            state.sections.append(DetailSectionModel.UserInfoSection(title: "UserInfoSection", items: [DetailSectionItem.UserInfoSectionItem(user: unsplash.user)]))
            return state
        }
    }

    
}

