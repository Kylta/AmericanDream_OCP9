//
//  Loader.swift
//  AmericanDream
//
//  Created by Christophe Bugnon on 18/03/2019.
//  Copyright © 2019 Christophe Bugnon. All rights reserved.
//

import Foundation

public enum LoadGenericResult<U> {
    case success(U)
    case failure(Error)
}

public protocol GenericLoader {
    associatedtype Model
    func load(completion: @escaping (LoadGenericResult<Model>) -> Void)
}
