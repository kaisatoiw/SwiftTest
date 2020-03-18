//
//  ViewController.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/08.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxDataSources
import RxCocoa
import Rswift

enum PostSection {
    case post
}

enum PostItem {
    case postWithImage(post: Post)
    case postNoImage(post: Post)
}

typealias PostSectionModel = SectionModel<PostSection, PostItem>
class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    private var refreshControl: UIRefreshControl!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var selfView: UIView!
    private var viewModel = PostViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<PostSectionModel>.ConfigureCell = { [weak self] (_, tableView, indexPath, item) in
        guard let _self = self else { return UICollectionViewCell() }
        switch item {
        case .postWithImage(let post):
            guard let cell = _self.postWithImageCell(indexPath: indexPath, post: post) as? RecommendCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case .postNoImage(let post):
                guard let cell = _self.postNoImageCell(indexPath: indexPath, post: post) as? PostNoImgaeCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
    }
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<PostSectionModel>(configureCell: configureCell)
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.layer.borderWidth = 0.5
        selfView.layer.borderColor = UIColor.lightGray.cgColor
        self.setupCollectionView()
        self.setupViewModel()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    
    private func setupCollectionView() {
//        flowLayout.itemSize.width = self.collectionView.bounds.width / 2.05
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        collectionView.contentInset.top = RecommendCollectionViewCell.cellMargin
        collectionView.register(UINib(resource: R.nib.recommendCollectionViewCell), forCellWithReuseIdentifier: R.nib.recommendCollectionViewCell.identifier)
        collectionView.register(UINib(resource: R.nib.postNoImgaeCollectionViewCell), forCellWithReuseIdentifier: R.nib.postNoImgaeCollectionViewCell.identifier)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.rx.itemSelected
            .map { [weak self] indexPath -> PostItem? in
                return self?.dataSource[indexPath]
        }
        .subscribe(onNext: { [weak self] item in
            // セルをタップしたとき、ここが呼ばれる
            guard let item = item else { return }
            //            switch item {
            //            case .post(let post):
            //                self?.presentArticleDetailViewController(Post: Post)
            //            }
        })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        // Loading Status
        viewModel.isLoading
            .asDriver()
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        // Pull Refresh
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe({ [unowned self] _ in self.viewModel.updateItems()})
            .disposed(by: disposeBag)
        // ここでdataSourceをdrive(bind)しておくことで、データの更新＆Viewの更新をきにしなくてもよくなる
        viewModel.items
            .asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        viewModel.updateItems()

        viewModel.page.asObservable()
        .subscribe(onNext: { [weak self] page in
            guard let _self = self else {
                return
            }
            _self.viewModel.updateItems(page: page)
        }).disposed(by: disposeBag)
    }
    
    private func postWithImageCell(indexPath: IndexPath, post: Post) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.recommendCollectionViewCell.name, for: indexPath) as? RecommendCollectionViewCell {
            cell.update(post: post)
            return cell
        }
        return UICollectionViewCell()
    }

    private func postNoImageCell(indexPath: IndexPath, post: Post) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.postNoImgaeCollectionViewCell.name, for: indexPath) as? PostNoImgaeCollectionViewCell {
            cell.update(post: post)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let item = dataSource[section]
        switch item.model {
        case .post:
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / 2.05, height: 300)
    }
}


extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = viewModel.page.value
        viewModel.page.accept(page + 1)
    }
}
