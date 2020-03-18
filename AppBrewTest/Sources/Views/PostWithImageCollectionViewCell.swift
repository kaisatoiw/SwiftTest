//
//  PostWithImageCollectionViewCell.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/08.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import UIKit
import SDWebImage
import RxRelay
import RxSwift
class PostWithImageCollectionViewCell: UICollectionViewCell {
    static let cellHeight: CGFloat = 300
    static let cellMargin: CGFloat = 4.0
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var clipCountLabel: UILabel!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var rateView: RateView!

    private let disposeBug = DisposeBag()

    var viewModel = PostCellViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        subscribeUI()
        subscribe()
    }

    func setupView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
        let rightConstraint = self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        let topConstraint = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])

        layer.cornerRadius = 12
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        iconImageView.clipsToBounds = true
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.white.cgColor
        likeButton.layer.cornerRadius = likeButton.bounds.height / 2
        likeButton.clipsToBounds = true
        likeButton.layer.borderWidth = 0.5
        likeButton.layer.borderColor = UIColor(red: 94/255, green: 63/255, blue: 63/255, alpha: 0.2).cgColor
        likeButton.imageView?.contentMode = .scaleAspectFill
        likeButton.contentHorizontalAlignment = .fill
        likeButton.contentVerticalAlignment = .fill
        likeButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 7, bottom: 8, right: 7)
        productImageView.layer.cornerRadius = productImageView.bounds.height / 2
        productImageView.clipsToBounds = true
        productImageView.layer.borderWidth = 0.5
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
    }

    func subscribeUI() {
        likeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let _self = self else {
                    return
                }
                let isLiked = _self.viewModel.likeState.value
                _self.viewModel.postLike(id: _self.viewModel.id, isLiked: isLiked)
            }).disposed(by: disposeBug)
    }

    func subscribe() {
        viewModel.likeState.asObservable()
            .subscribe(onNext: { [weak self] isLiked in
                guard let _self = self else {
                    return
                }
                _self.changeState(state: isLiked)
            }).disposed(by: disposeBug)

        viewModel.likeCount.asObservable()
            .subscribe(onNext: { [weak self] isLiked in
                guard let _self = self else {
                    return
                }
                _self.likeCountLabel.text = "\(_self.viewModel.likeCount.value)"
            }).disposed(by: disposeBug)

        viewModel.error.asObservable()
            .subscribe(onNext: { [weak self] error in
                guard let _self = self, let error = error else {
                    return
                }
                
            }).disposed(by: disposeBug)
    }
    
    func update(post: Post) {
        viewModel.id = post.id
        viewModel.likeState.accept(post.is_liked)
        viewModel.likeCount.accept(post.like_count)
        commentCountLabel.text = "\(post.comment_count)"
        clipCountLabel.text = "\(post.clip_count)"
        nameLabel.text = post.user.nickname
        descriptionLabel.text = post.abstract
        if let mainUrl = post.images.first??.thumb_url, let iconUrl = post.user.profile_image?.small_url {
            iconImageView.sd_setImage(with: URL(string: iconUrl))
            mainImageView?.sd_setImage(with: URL(string: mainUrl))
        }
        if let productTag = post.product_tags.first {
            productView.isHidden = false
            lineView.isHidden = false
            rateView.isHidden = false
            rateView.setRate(rate: productTag?.rate ?? 0)
            productNameLabel.text = productTag?.product.name
            brandNameLabel.text = productTag?.product.brand?.name
            productImageView.sd_setImage(with: URL(string: productTag?.product.small_image_url ?? ""))
        } else {
            productView.isHidden = true
            lineView.isHidden = true
            rateView.isHidden = true
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    private func clear() {
        nameLabel.text = nil
        descriptionLabel.text = nil
        mainImageView.image = nil
        iconImageView.image = nil
        productImageView.image = nil
        productNameLabel.text = nil
        brandNameLabel.text = nil
        likeCountLabel.text = nil
        commentCountLabel.text = nil
        clipCountLabel.text = nil
        mainImageView.sd_cancelCurrentImageLoad()
        iconImageView.sd_cancelCurrentImageLoad()
        productImageView.sd_cancelCurrentImageLoad()
    }

    func changeState(state: Bool) {
        likeButton.tintColor = state ? UIColor(red: 239/255, green: 132/255, blue: 145/255, alpha: 1) : UIColor(red: 94/255, green: 63/255, blue: 63/255, alpha: 0.2)
    }
}
