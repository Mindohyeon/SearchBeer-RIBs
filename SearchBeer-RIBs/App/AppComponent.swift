//
//  AppComponent.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import Foundation
import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
