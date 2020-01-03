//
//  SDWebImage+RX.swift
//  VeSync
//
//  Created by dave on 2019/8/17.
//  Copyright © 2019年 Etekcity. All rights reserved.
//

import Kingfisher
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    
    public var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil, options: [])
    }
    
    public func imageURL(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
}

extension Reactive where Base: UIButton {

    public func imageURL(withPlaceholder placeholderImage: UIImage?, state: UIControl.State, options: KingfisherOptionsInfo = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (button, url) in
            button.kf.setImage(with: url, for: .normal, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
    
    public func backgroundImageURL(withPlaceholder placeholderImage: UIImage?, state: UIControl.State, options: KingfisherOptionsInfo = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (button, url) in
            button.kf.setBackgroundImage(with: url, for: .normal, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
}
